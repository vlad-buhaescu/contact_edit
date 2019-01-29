import UIKit

public typealias Action = (Contact?) -> ()

enum Routing {
    case newContact(editContact: Action)
    case editContact(contact: Contact, rightAction: Action)
    case contactsList
    
    func makeScreen() -> UIViewController {
        switch self {
        case .editContact(let contact, let rightAction):
            let vm = EditContactViewModel(rightAction: rightAction, contactToEdit: contact)
            return AddContactViewController(viewModel: vm)
        case .contactsList:
            return ConstactsListViewController(viewModel: MainViewModel())
        case .newContact(let editContact):
            let vm = NewContactViewModel(rightAction: editContact)
            return AddContactViewController(viewModel: vm)
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
        case .editContact(_,_):
            Router.shared.navigation.pushViewController(a, animated: true)
        case .newContact:
            let nav = UINavigationController(rootViewController: a)
            Router.shared.navigation.present(nav, animated: true, completion: nil)
        }
    }
    
    func dismiss() {
        Router.shared.topController.dismiss(animated: true, completion: nil)
    }
    
    func pop() {
        Router.shared.navigation.popViewController(animated: true)
    }
}
