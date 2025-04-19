//
//  DeepLinkHandler.swift
//  Runner
//
//  Created for Wardaya App
//

import Foundation
import Flutter

class DeepLinkHandler {
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