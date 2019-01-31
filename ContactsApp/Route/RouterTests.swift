import XCTest
@testable import ContactsApp

final class RouterTests: XCTestCase {

    var sut: RouterType!
    
    override func setUp() {
        sut = Router()
        sut.setupNav(UINavigationController(rootViewController: UIViewController()))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_navigation() {
        XCTAssertNotNil(sut.navigation)
    }
    
    func test_navigation_show() {
        // WHEN
        sut.show(route: Routing.contactsList)
        
        // THEN
        XCTAssertTrue(sut.stack.count == 1)
    }
    
    func test_navigation_pop() {
        // GIVEN
        sut.setupNav(UINavigationController(rootViewController: UIViewController()))
        // WHEN
        sut.show(route: Routing.contactsList)
        sut.pop()
        // THEN
        XCTAssertTrue(sut.stack.count == 0)
    }
}
