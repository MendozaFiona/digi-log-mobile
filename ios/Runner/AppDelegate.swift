import UIKit
import Flutter
//import GoogleMaps -uncomment once free trial starts

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    /* uncomment once free trial starts
    GMSServices
      .provideAPIKey
      ("apikeyhere")
    */
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
