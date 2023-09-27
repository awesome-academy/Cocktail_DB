import UIKit

final class NoInternetViewController: UIViewController {
    @IBOutlet weak var tryAgainButton: UIButton!

    @IBAction func tryAgainTouchUp(_ sender: Any) {
        if InternetManager.shared.isInternetAvailable() {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.restartApp()
            }
        }
    }
}
