import UIKit
import Flutter
import GoogleMaps

@objc class DeepLinkHandler: NSObject {
    static let shared = DeepLinkHandler()
    private var methodChannel: FlutterMethodChannel?
    private var initialLink: String?
    
    // Initialize the method channel
    func registerMethodChannel(with binaryMessenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(name: "com.wardaya.app/deeplink", binaryMessenger: binaryMessenger)
        
        methodChannel?.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            if call.method == "getInitialLink" {
                // Return and clear the initial link
                result(self.initialLink)
                self.initialLink = nil
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    // Save the initial deep link when the app is launched from a URL
    func handleInitialDeepLink(_ url: URL) {
        initialLink = url.absoluteString
    }
    
    // Handle a deep link when the app is already running
    func handleDeepLink(_ url: URL) {
        // Send the deep link to Flutter via the method channel
        methodChannel?.invokeMethod("deepLink", arguments: url.absoluteString)
    }
}

@main
class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Safely unwrap the API key with a fallback
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "MAPS_API_KEY") as? String {
      GMSServices.provideAPIKey(apiKey)
    } else {
      // Fallback to hardcoded key from .env (only for development)
      GMSServices.provideAPIKey("AIzaSyD7HluzVXZGGBtjSTF1ld5QdoWgH1PZhLM")
      print("Warning: MAPS_API_KEY not found in Info.plist, using fallback key")
    }
    
    // Register plugins
    GeneratedPluginRegistrant.register(with: self)
    
    // Handle deep link if the app was opened with a URL
    if let url = launchOptions?[UIApplication.LaunchOptionsKey.url] as? URL {
      DeepLinkHandler.shared.handleInitialDeepLink(url)
    }
    
    // Check for universal link
    if let userActivity = launchOptions?[UIApplication.LaunchOptionsKey.userActivityDictionary] as? [AnyHashable: Any],
       let activity = userActivity["UIApplicationLaunchOptionsUserActivityKey"] as? NSUserActivity,
       activity.activityType == NSUserActivityTypeBrowsingWeb,
       let url = activity.webpageURL {
        DeepLinkHandler.shared.handleInitialDeepLink(url)
    }
    
    // Set up Flutter method channel for deep link communication
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    DeepLinkHandler.shared.registerMethodChannel(with: controller.binaryMessenger)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Handle URL scheme based deep links
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    DeepLinkHandler.shared.handleDeepLink(url)
    return true
  }
  
  // Handle Universal Links
  override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
       let url = userActivity.webpageURL {
      DeepLinkHandler.shared.handleDeepLink(url)
      return true
    }
    return false
  }
}