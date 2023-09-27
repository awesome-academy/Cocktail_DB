import Foundation

struct Cooktail: Decodable {
    var cooktailId: String?
    var cooktailName: String?
    var cooktailCategory: String?
    var cooktailAlcoholic: String?
    var cooktailImage: String?
    var ingredientNames: [String]?
    var ingredientMeansure: [String]?
    var instruction: String?
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
        case instruction = "strInstructions"
    }
    init(cooktailId: String, cooktailName: String, cooktailCategory: String, ingrediant: Ingredient) {
        self.cooktailId = cooktailId
        self.cooktailName = cooktailName
        self.cooktailCategory = cooktailCategory
        self.ingredientNames?.append(ingrediant.ingredientName ?? "1")
        self.ingredientMeansure?.append(ingrediant.ingredientMeansure ?? "2")
    }
    init(cooktailId: String, cooktailName: String, cooktailCategory: String, instruction: String) {
        self.cooktailId = cooktailId
        self.cooktailName = cooktailName
        self.cooktailCategory = cooktailCategory
        self.instruction = instruction
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cooktailId = try container.decodeIfPresent(String.self, forKey: .cooktailId)
        cooktailName = try container.decodeIfPresent(String.self, forKey: .cooktailName)
        cooktailCategory = try container.decodeIfPresent(String.self, forKey: .cooktailCategory)
        cooktailAlcoholic = try container.decodeIfPresent(String.self, forKey: .cooktailAlcoholic)
        cooktailImage = try container.decodeIfPresent(String.self, forKey: .cooktailImage)
        instruction = try container.decodeIfPresent(String.self, forKey: .instruction)
        ingredientNames = (1...Constant.Ingrediant.ingrediantTotal).compactMap { index in
            if let key = CodingKeys(rawValue: "strIngredient\(index)") {
                return try? container.decode(String.self, forKey: key)
            }
            return nil
        }
        ingredientMeansure = (1...Constant.Ingrediant.ingrediantTotal).compactMap { index in
            if let key = CodingKeys(rawValue: "strMeasure\(index)") {
                return try? container.decode(String.self, forKey: key)
            }
            return nil
        }
    }
    init(cooktails: CooktailData) {
        cooktailName = cooktails.cooktailName
        cooktailId = cooktails.cooktailId
        cooktailImage = cooktails.cooktailImage
        cooktailCategory = cooktails.cooktailCategory
    }
}

struct Cooktails: Decodable {
    let cooktails: [Cooktail]?
    enum CodingKeys: String, CodingKey {
            case cooktails = "drinks"
    }
}
