import UIKit
import Flutter
import GoogleMaps

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
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}