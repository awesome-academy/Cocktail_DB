import UIKit

final class ListViewController: UIViewController {
    private var categories: [Category]?
    private var cooktails: [Cooktail]?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cooktails = self.cooktails {
            print(cooktails)
        }
    }
    func setCategories(categories: [Category]) {
        self.categories = categories
    }
    func setCooktails(cooktails: [Cooktail]) {
        self.cooktails = cooktails
    }
}
