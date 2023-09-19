import UIKit

final class DetailCooktailViewController: UIViewController {
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var cooktailDescriptionLabel: UILabel!
    @IBOutlet private weak var alcoholicLabel: UILabel!
    @IBOutlet private weak var cooktailImage: UIImageView!
    @IBOutlet private weak var connerView: UIView!
    private var cooktail: Cooktail?
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    private func config() {
        // TODO: Setup title in navigationController equal cooktailName
        backgroundView.layer.cornerRadius = Constant.DetailDefaultConfig.cornerRadius
        cooktailImage.layer.cornerRadius = Constant.DetailDefaultConfig.imageCornerRadius
        connerView.layer.cornerRadius = Constant.DetailDefaultConfig.connerCornerRadius
    }
    func setCooktail(cooktail: Cooktail) {
        self.cooktail = cooktail
    }
}
