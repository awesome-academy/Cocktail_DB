import UIKit

final class DetailCooktailViewController: UIViewController {
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var cooktailDescriptionLabel: UILabel!
    @IBOutlet private weak var alcoholicLabel: UILabel!
    @IBOutlet private weak var cooktailImage: UIImageView!
    @IBOutlet private weak var connerView: UIView!
    @IBOutlet private weak var ingrediantCollectionView: UICollectionView!
    private var cooktail: Cooktail?
    private var ingrediants: [Ingredient] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ingrediantSetting()
        config()
    }
    private func config() {
        ingrediantCollectionView.register(nibName: IngrediantCollectionViewCell.self)
        ingrediantCollectionView.dataSource = self
        self.navigationController?.title = cooktail?.cooktailName
        if let layout = ingrediantCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        backgroundView.layer.cornerRadius = Constant.DetailDefaultConfig.cornerRadius
        cooktailImage.layer.cornerRadius = Constant.DetailDefaultConfig.imageCornerRadius
        connerView.layer.cornerRadius = Constant.DetailDefaultConfig.connerCornerRadius
    }
    private func ingrediantSetting() {
        // TODO: Ingredient get data from cooktail
        ingrediants.append(Ingredient(ingredientId: "1",
                                       ingredientName: "Gin",
                                       ingredientMeansure: "1 shot",
                                       ingredientDescription: "nothing"))
        ingrediants.append(Ingredient(ingredientId: "1",
                                       ingredientName: "Vodka",
                                       ingredientMeansure: "1 shot",
                                       ingredientDescription: "nothing"))
        ingrediants.append(Ingredient(ingredientId: "1",
                                       ingredientName: "Gin",
                                       ingredientMeansure: "1 shot",
                                       ingredientDescription: "nothing"))
        ingrediants.append(Ingredient(ingredientId: "1",
                                       ingredientName: "Gin",
                                       ingredientMeansure: "1 shot",
                                       ingredientDescription: "nothing"))
        ingrediants.append(Ingredient(ingredientId: "1",
                                       ingredientName: "Gin",
                                       ingredientMeansure: "1 shot",
                                       ingredientDescription: "nothing"))
        ingrediants.append(Ingredient(ingredientId: "1",
                                       ingredientName: "Gin",
                                       ingredientMeansure: "1 shot",
                                       ingredientDescription: "nothing"))
    }
    func setCooktail(cooktail: Cooktail) {
        self.cooktail = cooktail
    }
    @IBAction private func instructionButtonTouchUp (_ sender: Any) {
        if let instructionView = storyboard?.instantiateViewController(
            withIdentifier: Constant.ControllerView.instruction) {
            self.navigationController?.pushViewController(instructionView, animated: true)
        }
    }
}
extension DetailCooktailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingrediants.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(IngrediantCollectionViewCell.self, indexPath: indexPath)
        print(ingrediants[indexPath.row])
        cell.configIngredient(ingrediant: ingrediants[indexPath.row])
        return cell
    }
}
