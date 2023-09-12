import Foundation

struct Cooktail: Decodable {
    var cooktailId: String?
    var cooktailName: String?
    var cooktailCategory: String?
    var cooktailAlcoholic: String?
    var cooktailImage: String?
    var ingredientNames: [String]?
    var ingredientMeansure: [String]?
    enum CodingKeys: String, CodingKey {
        case cooktailId = "idDrink"
        case cooktailName = "strDrink"
        case cooktailCategory = "strCategory"
        case cooktailAlcoholic = "strAlcoholic"
        case cooktailImage = "strDrinkThumb"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
             strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
             strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
             strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
             strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cooktailId = try container.decodeIfPresent(String.self, forKey: .cooktailId)
        cooktailName = try container.decodeIfPresent(String.self, forKey: .cooktailName)
        cooktailCategory = try container.decodeIfPresent(String.self, forKey: .cooktailCategory)
        cooktailAlcoholic = try container.decodeIfPresent(String.self, forKey: .cooktailAlcoholic)
        cooktailImage = try container.decodeIfPresent(String.self, forKey: .cooktailImage)
        ingredientNames = (1...15).compactMap { index in
            if let key = CodingKeys(rawValue: "strIngredient\(index)") {
                return try? container.decode(String.self, forKey: key)
            }
            return nil
        }
        ingredientMeansure = (1...15).compactMap { index in
            if let key = CodingKeys(rawValue: "strMeasure\(index)") {
                return try? container.decode(String.self, forKey: key)
            }
            return nil
        }
    }
}

struct Cooktails: Decodable {
    let cooktails: [Cooktail]?
    enum CodingKeys: String, CodingKey {
            case cooktails = "drinks"
    }
}
