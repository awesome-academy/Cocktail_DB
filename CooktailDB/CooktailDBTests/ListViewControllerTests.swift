import XCTest
@testable import CooktailDB
class ListViewControllerTests: XCTestCase {
    var list: ListViewController!
    private let data = ["Cocktail", "Ordinary%20Drink", "Coffee%20%5C/%20Tea", "Soft%20Drink"]
    private let image = ["Popular", "Ordinary_Drink", "Coffee_Tea", "Soft_Drink_Soda"]

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        list = storyboard.instantiateViewController(withIdentifier: Constant.ControllerView.list) as? ListViewController
        list.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        list = nil
        super.tearDown()
    }

    func testIsCategories() throws {
        let categories = (0..<data.count).map { index in
            return Category(categoryImage: image[index],
                            categoryName: data[index],
                            categoryNumber: index + 1)
        }
        list.setCategories(categories: categories)
        list.viewDidLoad()
        XCTAssertEqual(
            list.collectionView(list.listViewCollectionView,
                                cellForItemAt: IndexPath(row: 0, section: 0)).reuseIdentifier,
            Constant.CategoryCollectionViewConfig.cellWithReuseIdentifier)
        list.collectionView(list.listViewCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        list.searchBar(list.searchBar, textDidChange: "he")
    }

    func testIsCooktail() throws {
        let cooktails = (0..<2).map { _ in
            return Cooktail(cooktailId: "1", cooktailName: "2", cooktailCategory: "3", instruction: "4")
        }
        list.setCooktails(cooktails: cooktails)
        list.viewDidLoad()
        XCTAssertEqual(
            list.collectionView(list.listViewCollectionView,
                                cellForItemAt: IndexPath(row: 0, section: 0)).reuseIdentifier,
            Constant.CooktailListCell.defaultCellReusealble)
        list.collectionView(list.listViewCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }
}
