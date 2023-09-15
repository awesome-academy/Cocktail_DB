import UIKit

final class CategoryViewCellCollectionViewCell: UICollectionViewCell, ReusableView {
    static var defaultReuseIdentifier = Constant.CategoryCollectionViewConfig.cellWithReuseIdentifier
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
        self.categoryName.text = category.categoryName?.replacingOccurrences(of: "%20", with: " ")
            .replacingOccurrences(of: "%5C", with: "")
        if let number = category.categoryNumber {
            self.categoryNumber.text = "\(number) mixes"
        }
    }
}
