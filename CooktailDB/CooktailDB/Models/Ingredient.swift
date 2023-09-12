import Foundation
struct Ingredient: Decodable {
    var ingredientId: String?
    var ingredientName: String?
    var ingredientMeansure: String?
    var ingredientDescription: String?
    enum CodingKeys: String, CodingKey {
            case ingredientId = "idIngredient"
            case ingredientName = "strIngredient"
            case ingredientDescription = "strDescription"
    }
}
