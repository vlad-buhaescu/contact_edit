import UIKit

public typealias Action = (Contact?) -> ()

enum Routing {
    case newContact
    case editContact(contact: Contact?, leftAction: Action, rightAction: Action)
    case contactsList
    
    func makeScreen() -> UIViewController {
        switch self {
        case .editContact(let contact, let leftAction, let rightAction):
            let leftButton = BarButton(buttonStyle: UIBarButtonItem.SystemItem.add, onTapAction: leftAction)
            let rightButton = BarButton(buttonStyle: UIBarButtonItem.SystemItem.cancel, onTapAction: rightAction)
            let vm = AddContactViewModel(leftButton: leftButton, contactToEdit: contact)
            return AddContactViewController(viewModel: vm)
        case .contactsList:
            return ConstactsListViewController(viewModel: MainViewModel())
        case .newContact:
            return UIViewController()
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
        Router.shared.topController = a
        switch route {
        case .contactsList:
            Router.shared.navigation.pushViewController(a, animated: false)
        case .editContact(_,_,_):
            Router.shared.navigation.pushViewController(a, animated: false)
        case .newContact:
            let nav = UINavigationController(rootViewController: a)
            Router.shared.navigation.present(nav, animated: true, completion: nil)
        }
    }
    
    func dismiss() {
        Router.shared.topController.dismiss(animated: true, completion: nil)
    }
}
