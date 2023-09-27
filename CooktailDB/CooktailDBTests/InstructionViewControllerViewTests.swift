import XCTest
@testable import CooktailDB
class InstructionViewControllerViewTests: XCTestCase {
    var instruction: IntructionViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        instruction = storyboard.instantiateViewController(
            withIdentifier: Constant.ControllerView.instruction) as? IntructionViewController
        instruction.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        instruction = nil
        self.tearDown()
    }

    func testExample() throws {
        instruction.configCooktail(cooktail:
                                    Cooktail(cooktailId: "1",
                                             cooktailName: "2",
                                             cooktailCategory: "3",
                                             instruction: "4"))
        print(instruction.cooktail as Any)
        instruction.viewDidLoad()
    }
}
