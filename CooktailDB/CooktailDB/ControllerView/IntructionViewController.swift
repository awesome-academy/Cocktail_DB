import UIKit

final class IntructionViewController: UIViewController {
    @IBOutlet private weak var cooktailName: UILabel!
    @IBOutlet private weak var cooktailInstruction: UILabel!
    private var cooktail: Cooktail?
    override func viewDidLoad() {
        super.viewDidLoad()
        configContent()
    }
    private func configContent() {
        self.title = cooktail?.cooktailName
        cooktailName.text = cooktail?.cooktailName
        cooktailInstruction.text = cooktail?.instruction
    }
    func configCooktail(cooktail: Cooktail?) {
        self.cooktail = cooktail
    }
}
