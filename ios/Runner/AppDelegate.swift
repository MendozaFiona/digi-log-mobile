import UIKit
import Flutter
//import GoogleMaps -uncomment once free trial starts

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GMSServices
      .provideAPIKey
      ("AIzaSyAZMoeYwVxlqO0o9r48HDrNonRcaBPg0hk")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
