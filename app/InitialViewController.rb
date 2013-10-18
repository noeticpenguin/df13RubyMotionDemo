class InitialViewController < UIViewController

  def initWithNibName(nibNameOrNil, bundle:nibBundleOrNil)
    super
    p "Inside InitialViewController"
    if self
      # Custom init code goes here
    end
    self
  end

  def viewDidLoad()
    super
    # custom setup goes here
  end

  def didReceiveMemoryWarning()
    super
    # Dispose of un-needed resource
  end

end