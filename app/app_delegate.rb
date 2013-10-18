class AppDelegate

  attr_accessor :window, :initialLoginSuccessBlock, :initialLoginFailureBlock

  # def OAuthLoginDomain()
  #   # You can manually override and force your app to use 
  #   # a sandbox by changing this to test.salesforce.com
  #   "login.salesforce.com"
  # end

  def RemoteAccessConsumerKey()
    # Specify your connected app's consumer key here
    "3MVG9A2kN3Bn17hsUZHiKXv6UUn36wtG7rPTlcsyH8K4jIUB2O2CU4dHNILQ_6lD_l9uDom7TjTSNEfRUE6PU"
  end

  def OAuthRedirectURI()
    # This must match the redirect url specified in your
    # connected app settings. This is a fake url scheme
    # but for a mobile app, so long as it matches you're good.
    "testsfdc:///mobilesdk/detect/oauth/done"
  end

  # def initialLoginSuccessBlock()
  #   p "in InitialLoginSuccessBlock"
  #   # method(:setupRootViewController)
  #   @weakSelf = WeakRef.new(self)
  #   @weakSelf.setupRootViewController
  # end

  # def initialLoginFailureBlock(info, error)
  #   p "in InitialLoginFailureBlock"
  #   SFAuthenticationManager.sharedManager.logout()
  # end

  def dealloc()
    NSNotificationCenter.defaultCenter.removeObserver(self, name:"kSFUserLogoutNotification", object:SFAuthenticationManager.sharedManager)
    NSNotificationCenter.defaultCenter.removeObserver(self, name:"kSFLoginHostChangedNotification", object:SFAuthenticationManager.sharedManager)
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    if self
      SFLogger.setLogLevel(SFLogLevelDebug)
      SFAccountManager.setClientId(RemoteAccessConsumerKey())
      SFAccountManager.setRedirectUri(OAuthRedirectURI())
      SFAccountManager.setScopes(NSSet.setWithObjects("api", nil))
      NSNotificationCenter.defaultCenter.addObserver(self, selector: :logoutInitiated, name: "kSFUserLogoutNotification", object:SFAuthenticationManager.sharedManager)
      NSNotificationCenter.defaultCenter.addObserver(self, selector: :loginHostChanged, name: "kSFLoginHostChangedNotification", object:SFAuthenticationManager.sharedManager)
      p "Test"

      @weakSelf = WeakRef.new(self)
      self.initialLoginSuccessBlock = lambda { |info| 
        @weakSelf.setupRootViewController
      }

      self.initialLoginFailureBlock = lambda { |info,error|
        SFAuthenticationManager.sharedManager.logout
      }

    end
    p "In application 1"
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    p "In application 2"
    self.initializeAppViewState
    p "In application 3, launching login window"
    SFAuthenticationManager.sharedManager.loginWithCompletion(self.initialLoginSuccessBlock, failure:self.initialLoginFailureBlock)
    p "In application 4"
    true
  end

  def initializeAppViewState()
    @window.rootViewController = InitialViewController.alloc.initWithNibName(nil, bundle:nil)
    @window.makeKeyAndVisible
  end

  def setupRootViewController()
    p "setting up root view controller"
    rootVC = RootViewController.alloc.initWithNibName(nil, bundle:nil)
    navVC = UINavigationController.alloc.initWithRootViewController(rootVC)
    @window.rootViewController = navVC 
  end

  def logoutInitiated(notification)
    self.log.SFLogLevelDebug(msg:"Logout Notification Recieved. Resetting App")
    self.initializeAppViewState
    SFAuthenticationManager.sharedManager.loginWithCompletion(self.initialLoginSuccessBlock, failure:self.initialLoginFailureBlock)
  end

  def loginHostChanged(notification)
    self.log.SFLogLevelDebug(msg:"Login Host Changed Notification Recieved. Resetting App")
    self.initializeAppViewState
    SFAuthenticationManager.sharedManager.loginWithCompletion(self.initialLoginSuccessBlock, failure:self.initialLoginFailureBlock)
  end

end
