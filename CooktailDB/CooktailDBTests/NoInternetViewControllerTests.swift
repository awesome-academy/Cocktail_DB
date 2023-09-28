import XCTest
@testable import CooktailDB
class NoInternetViewControllerTests: XCTestCase {
    var noInternetView: NoInternetViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        noInternetView = NoInternetViewController()
        noInternetView.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        noInternetView = nil
        self.tearDown()
    }

    func testExample() throws {
        noInternetView.viewDidLoad()
        noInternetView.tryAgainTouchUp(noInternetView.tryAgainButton as Any)
    }
}
