import UIKit

final class CooktailCollectionViewCell: UICollectionViewCell, ReusableView {
    static var defaultReuseIdentifier = Constant.CooktailListCell.defaultCellReusealble
    @IBOutlet private weak var cooktailImage: UIImageView!
    @IBOutlet private weak var cooktailName: UILabel!
    @IBOutlet private weak var cooktailCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }

    private func config() {
        backgroundColor = UIColor(hex: "#FB7D8A")
        layer.cornerRadius = Constant.FavoriteCollectionViewConfig.cornerRadius
        cooktailImage.layer.cornerRadius = Constant.CooktailListCell.imageConnerRadius
    }

    func setData(cooktail: Cooktail) {
        guard let cooktailImage = cooktail.cooktailImage else { return }
        let safeUrl = cooktailImage + "/preview"

        APIManager.shared.getImg(url: safeUrl) { [weak self] image in
            guard let self = self else { return }
            self.cooktailImage.image = image
        }
        cooktailName.text = cooktail.cooktailName
        cooktailCategory.text = cooktail.cooktailCategory
    }

}
