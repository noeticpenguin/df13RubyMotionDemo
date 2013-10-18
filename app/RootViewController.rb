class RootViewController < UITableViewController

  attr_accessor :dataRows

  def didReceiveMemoryWarning
    super
  end

  def dealloc
    @dataRows = nil
  end

  def viewDidLoad
    super
    self.title = "Dreamforce Demo App"
    @dataRows = {} #[]
    request = SFRestAPI.sharedInstance.requestForQuery("SELECT Id, FirstName, LastName from Contact")
    SFRestAPI.sharedInstance.send(request, delegate: self)
  end

  # SFRestAPI protocol methods
  def request(request, didLoadResponse: jsonResponse)
    ap "Firing reload Table"
    records = jsonResponse.objectForKey("records")
    @dataRows = reindex_table_data(records)
    self.tableView.reloadData
  end

  def request(request, didFailLoadWithError: error)
    puts "Request:DidFailLoadWithError: #{error}"
    # @todo: better error handling here.
  end

  def requestDidCancelLoad(request)
    puts "Request:requestDidCancelLoad: #{request}"
    # @todo: better error handling here.
  end

  def requestDidTimeout(request)
    puts "Request:requestDidTimeout: #{request}"
    # @todo: better error handling here.
  end

  def reindex_table_data(incoming)
    tmp = {}
    ("A".."Z").each do |l|
      tmp[l] = incoming.select {|i| i["LastName"].starts_with? l}
    end
    tmp.delete_if {|k,v| v.empty?}
    tmp
  end

  # UITableView Protocol methods
  def numberOfSectionsInTableView(tableView)
    return @dataRows.count
  end

  # def dataRows
  #   @dataRows = {} if @dataRows.nil?
  #   @dataRows
  # end

  def tableView(tableView, numberOfRowsInSection:section)
    rows_for_section(section).size rescue 0 #if it's null because we've not yet loaded the data.
  end

  def sections
    @dataRows.keys.sort
  end

  def rows_for_section(section_index)
    @dataRows[self.sections[section_index]]
  end

  def row_for_index_path(index_path)
    rows_for_section(index_path.section)[index_path.row]
  end

  def tableView(tableView, titleForHeaderInSection:section)
    sections[section]
  end

  def sectionIndexTitlesForTableView(tableView)
    sections
  end

  def tableView(tableView, sectionForSectionIndexTitle: title, atIndex: index)
    sections.index title
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier) if cell.nil?
    image = UIImage.imageNamed('glyphicons_003_user.png')
    cell.imageView.image = image

    # Have the cell show data.
    rowObj = row_for_index_path(indexPath)
    cell.textLabel.text = "#{rowObj["FirstName"]} #{rowObj["LastName"]}"

    #add the arrow to the right hand side.
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

end