import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Router.shared.show(route: Routing.contactsList(rightAction: {
            Router.shared.show(route: .editContact(contact: nil, leftAction: {}, rightAction: {}))
        }))
    }
}
