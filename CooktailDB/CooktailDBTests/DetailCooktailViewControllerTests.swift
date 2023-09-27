import XCTest
@testable import CooktailDB
class DetailCooktailViewControllerTests: XCTestCase {
    var detail: DetailCooktailViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        detail = storyboard.instantiateViewController(
            withIdentifier: Constant.ControllerView.detail) as? DetailCooktailViewController
        detail.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        detail = nil
        super.tearDown()
    }

    func testExample() throws {
        let cooktail = Cooktail(cooktailId: "1",
                                cooktailName: "2",
                                cooktailCategory: "3",
                                ingrediant: Ingredient(ingredientId: "1",
                                                       ingredientName: "Gin",
                                                       ingredientMeansure: "3",
                                                       ingredientDescription: "4"))

        detail.ingrediants.append(Ingredient(ingredientId: "1",
                                             ingredientName: "Gin",
                                             ingredientMeansure: "3",
                                             ingredientDescription: "4"))
        detail.setCooktail(cooktail: cooktail)
        detail.viewDidLoad()
        XCTAssertEqual(
            detail.collectionView(detail.ingrediantCollectionView,
                                  cellForItemAt: IndexPath(row: 0, section: 0)).reuseIdentifier,
            Constant.IngrediantCollectionViewCellConfig.cellWithReuseIdentifier)
        detail.touchUpFavorite(detail.favoriteButton as Any)
    }
}
