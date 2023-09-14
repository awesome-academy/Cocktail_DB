import UIKit

final class DetailCooktailViewController: UIViewController {
    private var cooktail: Cooktail?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setCooktail(cooktail: Cooktail) {
        self.cooktail = cooktail
    }
}
