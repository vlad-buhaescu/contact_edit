import UIKit

typealias Action = () -> ()

enum Routing {
    
    case editContact(contact: Contact?, leftAction: Action, rightAction: Action)
    case contactsList(rightAction: Action)
    
    func makeScreen() -> UIViewController {
        switch self {
        case .editContact(let contact, let leftAction, let rightAction):
            let leftButton = BarButton(buttonStyle: UIBarButtonItem.SystemItem.add, onTapAction: leftAction)
            let rightButton = BarButton(buttonStyle: UIBarButtonItem.SystemItem.cancel, onTapAction: rightAction)
            let vm = AddContactViewModel(title: "Edit contact", leftButton: leftButton, rightButton: rightButton, contactToEdit: contact)
            return AddContactViewController(viewModel: vm)
        case .contactsList(let rightAction):
            let button = BarButton(buttonStyle: UIBarButtonItem.SystemItem.add, onTapAction: rightAction)
            let vm = MainViewModel(title: "Contact list", rightButton: button)
            return ConstactsListViewController(viewModel: vm)
        }
    }
}

class Router {
    var navigation: UINavigationController!
    var topController: UIViewController!
    static let shared = Router()
    
    func setupNav(_ navigationController: UINavigationController) {
        navigation = navigationController
    }
    
    func show(route: Routing) {
        let a = route.makeScreen()
        switch route {
        case .contactsList(_):
            Router.shared.navigation.pushViewController(a, animated: false)
        case .editContact(_,_,_):
            let nav = UINavigationController(rootViewController: a)
            Router.shared.navigation.present(nav, animated: true, completion: nil)
        }
        
    }
}
