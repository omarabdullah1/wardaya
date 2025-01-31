import UIKit
import Flutter
import FirebaseCore // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize Firebase
    FirebaseApp.configure() // Add this line

    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // Call the superclass method
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}