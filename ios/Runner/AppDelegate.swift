import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window.rootViewController as! FlutterViewController
        
        let flavorChannel = FlutterMethodChannel(
            name: "flavor",
            binaryMessenger: controller.binaryMessenger)
        
        flavorChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread
            let flavor = Bundle.main.infoDictionary?["App - Flavor"]
            result(flavor)
        })
        GMSServices.provideAPIKey("AIzaSyAMrpgVNPl5zF7DkFxeWZaD_Bh08eQKMyE")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
