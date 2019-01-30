import XCTest
@testable import ContactsApp

final class EditContactViewModelTests: XCTestCase {
    
    var sut: EditContactViewModel!
    
    override func setUp() {
        sut = EditContactViewModel(saveAction: makeAction(), contactToEdit: contact)
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
        XCTAssertEqual("Edit contact", sut.title)
    }
    
    func test_viewModels() {
        // GIVEN
        let numberOfCells = 2
        // THEN
        XCTAssertEqual(numberOfCells, sut.cellViewModels.count)
    }
    
    func test_contact_to_edit() {
        
        // THEN
        XCTAssertEqual(contact, sut.contactToEdit)
    }
    
    func test_save_button() {
        // THEN
        XCTAssertNil(sut.rightButton)
    }
    
    func test_save_action() {
        // THEN
//        XCTAssertEqual(action(), sut.rightButton?.onTapAction)
    }

    func test_left_action() {
        XCTAssertEqual(leftButton, sut.leftButton as? BarButton)
    }
    
    func test_edit_save() {
        // GIVEN
        let contact = Contact(firstName: "Johnny", lastName: "Cash")
        
        // WHEN
        sut.saveAction(contact)
        
        // THEN
        XCTAssertEqual(contact, sut.contactToEdit)
    }
    
    func test_edit_cancel() {
        // WHEN
        sut.leftButton?.onTapAction(contact)
        
        // THEN
        XCTAssertTrue(Router.shared.stack.count == 0)
    }
    
    func test_edit_cancel_exist() {
        // THEN
        XCTAssertNotNil(sut.leftButton)
    }
    
    func test_first_section() {
        // GIVEN
        let cell = sut.cellViewModels.first as? TextCellViewModelType
        
        // THEN
        XCTAssertNotNil(cell)
    }
    
    func test_first_section_cell_first_name() {
        // GIVEN
        let cell = sut.cellViewModels.first as? TextCellViewModelType
        let firstName = "name"
        cell?.onTextUpdate(firstName)
        
        // THEN
        XCTAssertEqual(firstName, sut.contactToEdit.firstName)
    }
    
    func test_first_section_last_name() {
        // GIVEN
        let cell = sut.cellViewModels[1] as? TextCellViewModelType
        
        // THEN
        XCTAssertNotNil(cell)
    }
    
    func test_first_section_cell_last_name_update() {
        // GIVEN
        let cell = sut.cellViewModels[1] as? TextCellViewModelType
        let firstName = "last name"
        cell?.onTextUpdate(firstName)
        
        // THEN
        XCTAssertEqual(firstName, sut.contactToEdit.lastName)
    }

    //MARK: - Private Properties
    
    private let contact = Contact(firstName: "Jim", lastName: "Rohn")
    private let leftButton = BarButton(buttonStyle: .cancel, onTapAction: { (contact) in
        Router.shared.dismiss()
    })
    
    //MARK: - Private Methods
    
    private func makeAction() -> Action {
        let action: Action = { (contact) in
            guard let contact = contact else { return }
            self.sut.contactToEdit = contact
        }
        return action
    }
}
