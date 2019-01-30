import UIKit

public typealias Action = (Contact?) -> ()

func ==(lhs: Action, rhs: Action) -> Bool {
    return lhs(nil) == rhs(nil)
}

enum Routing {
    case newContact(saveAction: Action)
    case editContact(contact: Contact, rightAction: Action)
    case contactsList
    
    func makeScreen() -> UIViewController {
        switch self {
        case .editContact(let contact, let saveAction):
            let vm = EditContactViewModel(saveAction: saveAction, contactToEdit: contact)
            return TableViewController(viewModel: vm)
        case .contactsList:
            return TableViewController(viewModel: MainViewModel())
        case .newContact(let editContact):
            let vm = NewContactViewModel(rightAction: editContact)
            return TableViewController(viewModel: vm)
        }
    }
}

protocol RouterType {
    var navigation: UINavigationController! { get set }
    var topController: UIViewController! { get set }
    var stack: [UIViewController] { get }
    func setupNav(_ navigationController: UINavigationController)
    func show(route: Routing)
    func dismiss()
    func pop()
}

class Router: RouterType {
    var navigation: UINavigationController!
    var topController: UIViewController!
    static let shared = Router()
    
    var stack: [UIViewController] = []
    
    func setupNav(_ navigationController: UINavigationController) {
        navigation = navigationController
    }
    
    func show(route: Routing) {
        let a = route.makeScreen()
        stack.append(a)
        topController = a
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
        if stack.count > 0 {
            stack.removeLast()
            Router.shared.topController.dismiss(animated: true, completion: nil)
        }
    }
    
    func pop() {
        if stack.count > 0 { stack.removeLast() }
        Router.shared.navigation.popViewController(animated: true)
    }
}

