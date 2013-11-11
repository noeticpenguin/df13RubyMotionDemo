# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
	require 'bundler'
	Bundler.require
	require 'motion-cocoapods'
rescue LoadError
end

Motion::Project::App.setup do |app|
	# Use `rake config' to see complete project settings.
	### General Information & Configuration
	app.name = "Dreamforce Demo App"								# Name of App
	app.version = "1.0" 														# Version of the App
	app.deployment_target = "6.0"										# Minimum IOS version Required for App
	app.device_family = [:iphone, :ipad]						# Devices this app can run on
	app.interface_orientations = [:portrait, 
															  :landscape_left, 
															  :landscape_right]	# Auto rotate to these device Orientations

	### Application Artwork
	app.icons = ["Icon.png",    										# iPad and iPhone 3 standard icon
							 "Icon@2x.png", 										# iPad and iPhone Retina icon
							 "Icon-72.png", 										# iPad home screen icon
							 "Icon-58.png", 										# Spotlight and Settings Retina icon
							 "Icon-29.png"] 										# Spotlight and Settings icon

	### Application Frameworks
	# You can *add* to this as neccessary but this is the minimum required
	# for Salesforce iOS SDK Use.
	app.frameworks += %w(CFNetwork CoreData MobileCoreServices SystemConfiguration Security)
	app.frameworks += %w(MessageUI QuartzCore OpenGLES CoreGraphics sqlite3)
	
	### Code signature, profile and Identifier info. ##Headache##
	# note that these config options can be specified on a per-environment
	# basis. app.development = development, non-release
	# 			 app.release 		 = production, release on app store
	# app.development do
	# 	# app.identifier =														# app ID from Portal
	# 	# app.codesign_certificate = 									# string name of codesigning certificate
	# 	# app.provisioning_profile = 									# .mobileprovision file to use
	# 	app.entitlements['get-task-allow'] = true			# Allows the Debugger to attach
	# end

	# app.release do
	# 	# app.identifier =														# app ID from Portal
	# 	# app.codesign_certificate = 									# string name of codesigning certificate
	# 	# app.provisioning_profile = 									# .mobileprovision file to use		
	# 	app.entitlements['get-task-allow'] = true			# Must be false for release!
	# end

	### Entitlements needed for both development and release
	# app.entitlements['keychain-access-groups'] = [
	# 	app.seed_id + '.' + app.identifier
	# ]

	### Additional libraries needed for Salesforce iOS SDK
	# You can generally add just about any dylib or static .a lib this way
	# These are system dylibs
	app.libs << "/usr/lib/libxml2.2.dylib"
	app.libs << "/usr/lib/libsqlite3.0.dylib"
	app.libs << "/usr/lib/libz.dylib"
	# These are provided by Salesforces' iOS SDK.
	app.libs << "vendor/openssl/libcrypto.a"
	app.libs << "vendor/openssl/libssl.a"
	app.libs << "vendor/RestKit/libRestKit.a"
	app.libs << "vendor/SalesforceCommonUtils/libSalesforceCommonUtils.a"
	app.libs << "vendor/SalesforceNativeSDK/libSalesforceNativeSDK.a"
	app.libs << "vendor/SalesforceOAuth/libSalesforceOAuth.a"
	app.libs << "vendor/sqlcipher/libsqlcipher.a"
	app.libs << "vendor/SalesforceSDKCore/libSalesforceSDKCore.a"
	app.libs << "vendor/sqlcipher/libsqlcipher.a"

	### Vendor projects
	# A vendor project, in RubyMotion speak, is a directory of source code to be compiled 
	# along with your app. Salesforce's iOS SDK relies on it's own version of several 
	# common iOS libraries (e.g. RestKit). When provided by the SDK, you must use the 
	# SDK's version.
	# 
	# The easiest way to bootstrap a RubyMotion project with the needed dependencies is
	# to follow the *native* iOS SDK installation instructions. Additionally install the
	# forceios npm module and use forceios to create a new native iOS application. This
	# will generate a folder for your app in which you'll find a "Dependencies" folder.
	# Copy this folder to your rubymotion project folder and rename to "vendor". 
	
	# RestKit
	app.vendor_project "vendor/RestKit", 
	:static, 
	:headers_dir => "RestKit"

	# Salesforce Common Utils
	app.vendor_project "vendor/SalesforceCommonUtils",
	:static,
	:headers_dir => "Headers/SalesforceCommonUtils"

	# Salesforce Native SDK
	app.vendor_project "vendor/SalesforceNativeSDK",
	:static,
	:headers_dir => "include/SalesforceNativeSDK"

	# Salesforce oAuth
	app.vendor_project "vendor/SalesforceOAuth", 
	:static,
	:headers_dir => "include/SalesforceOAuth"

	# Salesforce SDK Core
	app.vendor_project "vendor/SalesforceSDKCore",
	:static,
	:headers_dir => "include/SalesforceSDKCore"

	### CocoaPods
	# While this app doesn't directly use any CocoaPods, this rakefile demonstrates how
	# app.pods do
	# 	pod "FlurrySDK"																# Flurry Mobile Anaylitics SDK
	# 	pod "Appirater"																# prebuilt "please rate my app" widget
	# 	pod "MBProgressHUD"                           # Prettier progress Heads Up Display
	# end

	### TestFlight Integration
	# While this app doesn't directly integrate with TestFlight, RubyMotion
	# makes it pretty easy to do so, here's how:
	# app.testflight.sdk = "vendor/TestFlight"        # path relative to project root
	#                                                 # where you've downloaded the TestFlight
	#                                                 # SDK
	# app.testflight.api_token = 'big string'         # Your testflight API Token
	# app.testflight.team_token = 'other string'      # Your testflight Team Token

end
