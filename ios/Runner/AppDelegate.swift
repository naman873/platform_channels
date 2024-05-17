import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var counter = 0
    private var timer: Timer?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let flutterViewController = window?.rootViewController as? FlutterViewController {

    FlutterMethodChannel(name: "Calculator", binaryMessenger: flutterViewController.binaryMessenger)
        .setMethodCallHandler { call, result in

            let count = (call.arguments as? NSDictionary)?["count"] as? Int

            switch call.method {
            case "random":
                result(Int.random(in: 0..<100))
            case "incrementCounter", "decrementCounter":
                if count == nil {
                    result(FlutterError(code: "INVALID ARGUMENT", message: "Invalid Argument", details: nil))
                } else {
                    let updatedCount = call.method == "incrementCounter" ? count! + 1 : count! - 1
                    result(updatedCount)
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        //
        let channel = FlutterEventChannel(name: "eventChannelTimer", binaryMessenger: flutterViewController.binaryMessenger)
                channel.setStreamHandler(self)
        }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        // Send initial counter value when listener is added
        events(counter)

        // Periodically update the counter and send updates
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.counter += 1
            events(self.counter)
        }
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        // Stop updating the counter when listener is removed
        timer?.invalidate()
        timer = nil
        return nil
    }
}