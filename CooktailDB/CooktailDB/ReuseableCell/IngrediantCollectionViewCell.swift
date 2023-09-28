import UIKit

final class IngrediantCollectionViewCell: UICollectionViewCell, ReusableView {
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

    func configIngredient(ingrediant: Ingredient) {
        guard let name = ingrediant.ingredientName else { return }
        let safeUrl = Constant.BaseUrl.getApiBaseUrl + "/"
            + Constant.RelativeUrl.getImageIngredientRelativeUrl + "/"
            + name + ".png"

        APIManager.shared.getImg(url: safeUrl.replacingOccurrences(of: " ", with: "%20")) { [weak self] image in
            guard let self = self else { return }
            self.ingrediantImage.image = image
        }
        ingrediantName.text = ingrediant.ingredientName
        ingrediantMeansure.text = ingrediant.ingredientMeansure
    }
}
