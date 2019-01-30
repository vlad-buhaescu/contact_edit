import XCTest
@testable import ContactsApp

final class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    
    override func setUp() {
        sut = MainViewModel()
        Router.shared.setupNav(UINavigationController())
        Router.shared.show(route: .contactsList)
    }

    override func tearDown() {
        sut = nil
        Router.shared.stack = []
        Router.shared.topController = nil
        Router.shared.navigation = nil
        super.tearDown()
    }
    
    func test_title() {
        // GIVEN
        
        // WHEN
        
        // THEN
        XCTAssertEqual("Contact list", sut.title)
    }
    
    func test_viewModels() {
        // GIVEN
        let numberOfCells = 0
        // THEN
        XCTAssertEqual(numberOfCells, sut.cellViewModels.count)
    }
    
    func test_view_models_creation() {
        // GIVEN
        prepareGiven()
        let numberOfCells = 1
        // THEN
        XCTAssertEqual(numberOfCells, sut.cellViewModels.count)
    }
    
    func test_view_models_cell_not_nil() {
        // GIVEN
        prepareGiven()
        let cell = sut.cellViewModels.first as? ContactsCellViewModelType
        // THEN
        XCTAssertNotNil(cell)
    }
    
    func test_view_models_cell_title() {
        // GIVEN
        prepareGiven()
        let cell = sut.cellViewModels.first as? ContactsCellViewModelType
        let title = "Jim Rohn"
        // THEN
        XCTAssertEqual(title, cell?.name)
    }
    
    func test_view_models_cell_subtitle() {
        // GIVEN
        prepareGiven()
        let cell = sut.cellViewModels.first as? ContactsCellViewModelType
        let title = "Contact Name"
        // THEN
        XCTAssertEqual(title, cell?.labelName)
    }
    
    func test_right_action() {
        // GIVEN
        prepareGiven()
        // WHEN
        sut.rightButton?.onTapAction(nil)
        // THEN
//        XCTAssertTrue(Router.shared.stack.count == 0)
        print("stack is \(Router.shared.stack.count)")
    }
    
    func test_select_action() {
        // GIVEN
        prepareGiven()
        // WHEN
        sut.delegate?.didSelectIndex(1)
        // THEN
        print("stack is \(Router.shared.stack.count)")
//        XCTAssertTrue(Router.shared.stack.count == 2)
    }
    
    //MARK: - Private Methods
    
    private func prepareGiven() {
        let contact = Contact(firstName: "Jim", lastName: "Rohn")
        sut = MainViewModel(contacts: [contact])
    }
}
