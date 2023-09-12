import Foundation

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
        static let Popular = "Popular"
        static let lookUpById = "Ordinary_Drink"
        static let lookUpByIngredientId = "Coffee/Tea"
        static let filterByCategory = "Soft_Drink/Soda"
    }
    struct Alcoholic {
        static let nope = "Non_Alcoholic"
        static let yes = "Alcoholic"
    }
}
