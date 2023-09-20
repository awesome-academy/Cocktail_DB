import UIKit

class IngrediantCollectionViewCell: UICollectionViewCell, ReusableView {
    static var defaultReuseIdentifier = Constant.IngrediantCollectionViewCellConfig.cellWithReuseIdentifier
    @IBOutlet private weak var cellBackgroundView: UIView!
    @IBOutlet private weak var ingrediantImage: UIImageView!
    @IBOutlet private weak var ingrediantName: UILabel!
    @IBOutlet private weak var ingrediantMeansure: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    private func config() {
        cellBackgroundView.layer.cornerRadius = Constant.IngrediantCollectionViewCellConfig.backgroundCornerRadius
        ingrediantImage.layer.cornerRadius = Constant.IngrediantCollectionViewCellConfig.imageCornerRadius
    }
    func setData(ingrediant: Ingredient) {
        print(ingrediant)
        print(1)
        guard let name = ingrediant.ingredientName else { return }
        let safeUrl = Constant.BaseUrl.getApiBaseUrl + "/"
            + Constant.RelativeUrl.getImageIngredientRelativeUrl + "/"
            + name + ".png"
        print(safeUrl)
        APIManager.shared.getImg(url: safeUrl) { [weak self] image in
            guard let self = self else { return }
            self.ingrediantImage.image = image
        }
        ingrediantName.text = ingrediant.ingredientName
        ingrediantMeansure.text = ingrediant.ingredientMeansure
    }
}
