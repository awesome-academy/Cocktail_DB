import Foundation
import UIKit
class Constant {
    struct BaseUrl {
        static let getApiBaseUrl = "https://www.thecocktaildb.com"
    }
    struct RelativeUrl {
        static let getApiRelativeUrl = "/api/json/v1/1/"
        static let getImageIngredientRelativeUrl = "images"
    }
    struct Endpoint {
        static let search = "search.php?"
        static let lookUp = "lookup.php?"
        static let popular = "popular.php"
        static let random = "random.php"
        static let filter = "filter.php?"
        static let getIngredientsImage = "ingredients"
    }
    struct Category {
        static let popular = "Cocktail"
        static let ordinary = "Ordinary%20Drink"
        static let coffeeTea = "Coffee%20%5C/%20Tea"
        static let softSoda = "Soft%20Drink"
    }
    struct Alcoholic {
        static let nope = "Non_Alcoholic"
        static let yes = "Alcoholic"
    }
    struct CategoryCellConfig {
        static let cornerRadiusImage = 50
    }
    struct FavoriteCollectionViewConfig {
        static let cornerRadius: CGFloat = 10
        static let imageConnerRadius: CGFloat = 50
        static let cellSize = CGSize(width: 300, height: 730)
        static let uiNibNameCell = "FavoriteCollectionViewCell"
        static let cellWithReuseIdentifier = "FavoriteCollectionViewCell"
    }
    struct CategoryCollectionViewConfig {
        static let imageConnerRadius: CGFloat = 35
        static let backgrounConnerRadius: CGFloat = 20
        static let cellSize = CGSize(width: 100, height: 100)
        static let uiNibNameCell = "CategoryViewCellCollectionViewCell"
        static let cellWithReuseIdentifier = "CategoryCollectionViewCell"
    }
    struct ControllerView {
        static let detail = "DetailCooktailViewController"
        static let home = "HomeControllerView"
        static let list = "ListViewController"
    }
    struct CooktailListCell {
        static let imageConnerRadius: CGFloat = 57
        static let cellHeight: CGFloat = 200
        static let insetSession = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        static let itemPerRow: CGFloat = 2.0
        static let defaultCellReusealble = "CooktailCollectionViewCell"
    }
}
