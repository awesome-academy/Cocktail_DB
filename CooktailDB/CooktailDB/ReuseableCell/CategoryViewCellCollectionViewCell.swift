import UIKit

final class CategoryViewCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var categoryNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    private func config() {
        layer.cornerRadius = Constant.CategoryCollectionViewConfig.backgrounConnerRadius
        backgroundColor = UIColor(hex: "#FB7D8A")
        categoryImage.layer.cornerRadius = Constant.CategoryCollectionViewConfig.imageConnerRadius
    }
    func setData(category: Category) {
        if let image = category.categoryImage {
            self.categoryImage.image = UIImage(named: image)
        }
        self.categoryName.text = category.categoryName
        if let number = category.categoryNumber {
            self.categoryNumber.text = "\(number + 1) mixes"
        }
    }
}
