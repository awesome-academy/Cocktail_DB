import UIKit

final class DetailCooktailViewController: UIViewController {
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var cooktailDescriptionLabel: UILabel!
    @IBOutlet private weak var alcoholicLabel: UILabel!
    @IBOutlet private weak var cooktailImage: UIImageView!
    @IBOutlet private weak var connerView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var ingrediantCollectionView: UICollectionView!
    private var cooktail: Cooktail?
    private var ingrediants: [Ingredient] = []
    private let database = DatabaseManager()
    private var favoriteCooktail: CooktailData?
    override func viewDidLoad() {
        super.viewDidLoad()
        ingrediantSetting()
        config()
        configContent()
    }
    private func config() {
        ingrediantCollectionView.register(nibName: IngrediantCollectionViewCell.self)
        ingrediantCollectionView.dataSource = self
        self.title = cooktail?.cooktailName
        if let layout = ingrediantCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        backgroundView.layer.cornerRadius = Constant.DetailDefaultConfig.cornerRadius
        cooktailImage.layer.cornerRadius = Constant.DetailDefaultConfig.imageCornerRadius
        cooktailImage.layer.borderWidth = Constant.DetailDefaultConfig.imageBorderWidth
        cooktailImage.layer.borderColor = Constant.DetailDefaultConfig.imageBorderColor
        connerView.layer.cornerRadius = Constant.DetailDefaultConfig.connerCornerRadius
    }
    private func ingrediantSetting() {
        var index = 0
        if let ingredientNameList = cooktail?.ingredientNames,
           var ingrediantMeansureList = cooktail?.ingredientMeansure {
            while index < ingredientNameList.count {
                if index >= ingrediantMeansureList.count {
                    ingrediantMeansureList.append("some")
                }
                ingrediants.append(
                    Ingredient(ingredientId: "\(index)",
                               ingredientName: ingredientNameList[index],
                               ingredientMeansure: ingrediantMeansureList[index],
                               ingredientDescription: "nothing"))
                if index < ingrediantMeansureList.count {
                    index += 1
                } else {
                    break
                }
            }
        }
    }
    private func configContent() {
        guard let cooktailImage = cooktail?.cooktailImage else { return }
        let safeUrl = cooktailImage + Constant.Option.getSmallImage
        APIManager.shared.getImg(url: safeUrl) { [weak self] image in
            guard let self = self else { return }
            self.cooktailImage.image = image
        }
        categoryLabel.text = cooktail?.cooktailCategory
        alcoholicLabel.text = cooktail?.cooktailAlcoholic
        var ingrediantString = ""
        guard let ingrediants = cooktail?.ingredientNames else { return }
        for index in (0..<ingrediants.count) {
            ingrediantString += ingrediants[index]
            if index == ingrediants.count - 1 {
                break
            }
            ingrediantString += " and "
        }
        cooktailDescriptionLabel.text =
            "\(cooktail?.cooktailName ?? "") is " +
            "\(cooktail?.cooktailAlcoholic ?? "") cooktail with "
            + ingrediantString
        if let cooktail = cooktail {
            favoriteCooktail = database.checkFavorite(cooktailTarget: cooktail)
        }
        if let _ = favoriteCooktail {
            updateFavouriteButton()
        }
    }
    private func updateFavouriteButton() {
        let isFill = favoriteCooktail == nil
        favoriteButton.setImage(UIImage(systemName: isFill ?
                                            Constant.FavoriteButton.notFill:
                                            Constant.FavoriteButton.fill
                                            ), for: .normal)
    }
    func setCooktail(cooktail: Cooktail) {
        self.cooktail = cooktail
    }
    @IBAction private func instructionButtonTouchUp (_ sender: Any) {
        if let instructionView = storyboard?.instantiateViewController(
            withIdentifier: Constant.ControllerView.instruction) as? IntructionViewController {
            instructionView.configCooktail(cooktail: cooktail)
            self.navigationController?.pushViewController(instructionView, animated: true)
        }
    }
    @IBAction private func touchUpFavorite(_ sender: Any) {
        guard let cooktail = cooktail else { return }
                if let favoriteCooktail = favoriteCooktail {
                    database.context.delete(favoriteCooktail)
                    self.favoriteCooktail = nil
                } else {
                    favoriteCooktail = CooktailData(context: database.context)
                    favoriteCooktail?.cooktailId = cooktail.cooktailId
                    favoriteCooktail?.cooktailName = cooktail.cooktailName
                    favoriteCooktail?.cooktailImage = cooktail.cooktailImage
                    favoriteCooktail?.cooktailCategory = cooktail.cooktailCategory
                }
                try? database.context.save()
                updateFavouriteButton()
    }
}
extension DetailCooktailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingrediants.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(IngrediantCollectionViewCell.self, indexPath: indexPath)
        cell.configIngredient(ingrediant: ingrediants[indexPath.row])
        return cell
    }
}
