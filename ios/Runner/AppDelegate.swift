import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var blurEffectView: UIVisualEffectView?
  private var isInBackground: Bool = false // Track whether app is in background
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func applicationWillResignActive(_: UIApplication ) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

    // Default Hidden
    // self.window?.isHidden = true;

    // Custom Hidden
    if !isInBackground {
      isInBackground = true // App entered background
      enableAppSecurity()
    }
  }

  override func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    // Default Hidden
    // self.window?.isHidden = true;

    // Custom Hidden
    if !isInBackground {
      isInBackground = true // App entered background
      enableAppSecurity()
    }
  }

  override func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    // Default Hidden
    // self.window?.isHidden = false;

    // Custom Hidden
    if isInBackground {
      isInBackground = false
      disableAppSecurity()
    }
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    // Default Hidden
    // self.window?.isHidden = false;

    // Custom Hidden
    if isInBackground {
      isInBackground = false
      disableAppSecurity()
    }
  }

  private func enableAppSecurity() {
    let blurEffect = UIBlurEffect(style: .extraLight)
    blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView?.frame = window!.frame
    self.window?.addSubview(blurEffectView!)
  }

  private func disableAppSecurity() {
    blurEffectView?.removeFromSuperview()
  }
}
