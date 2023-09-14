import UIKit

final class ListViewController: UIViewController {
    private var categories: [Category]?
    private var cooktails: [Cooktail]?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setCategories(categories: [Category]) {
        self.categories = categories
    }
    func setCooktails(cooktails: [Cooktail]) {
        self.cooktails = cooktails
    }
}
