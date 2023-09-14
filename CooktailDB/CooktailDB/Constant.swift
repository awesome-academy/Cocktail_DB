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
        static let popular = "Popular"
        static let ordinary = "Ordinary_Drink"
        static let coffeeTea = "Coffee/Tea"
        static let softSoda = "Soft_Drink/Soda"
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
        static let cellSize = CGSize(width: 254, height: 430)
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

}
