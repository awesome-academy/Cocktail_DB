import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let hasInternet = InternetManager.shared.isInternetAvailable()
        let navigationController = UINavigationController(
            rootViewController: ViewController.instantiateFromStoryboard())
        window?.rootViewController = hasInternet ? navigationController : NoInternetViewController()
        window?.makeKeyAndVisible()
        return true
    }

    func restartApp() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(
            rootViewController: ViewController.instantiateFromStoryboard())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
