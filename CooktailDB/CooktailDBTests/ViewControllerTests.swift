import XCTest
@testable import CooktailDB
class ViewControllerTests: XCTestCase {
    var viewController: ViewController!

    override func setUpWithError() throws {
        self.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(
            withIdentifier: Constant.ControllerView.home) as? ViewController
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testExample() throws {
        viewController.viewDidLoad()
        sleep(10)
        XCTAssertEqual(viewController.collectionView(
                        viewController.categoryCollectionView,
                        cellForItemAt: IndexPath(row: 0, section: 0)).reuseIdentifier,
                       Constant.CategoryCollectionViewConfig.cellWithReuseIdentifier)
        XCTAssertEqual(viewController.collectionView(
                        viewController.favoriteCollectionView,
                        cellForItemAt: IndexPath(row: 0, section: 0)).reuseIdentifier,
                       Constant.FavoriteCollectionViewConfig.cellWithReuseIdentifier)
    }

    func testFetchRandom() throws {
        let expectation = XCTestExpectation(description: "Your expectation description")

        viewController.viewDidLoad()
        sleep(10)
        if viewController.getRandomCooktail().isEmpty {
            XCTFail("Fetch Data Favorite Not Pass")
        }
        expectation.fulfill()
    }
}
