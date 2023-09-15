import UIKit

final class DetailCooktailViewController: UIViewController {
    private var cooktail: Cooktail?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cooktail = cooktail {
            print(cooktail)
        }
    }
    func setCooktail(cooktail: Cooktail) {
        self.cooktail = cooktail
    }
}
