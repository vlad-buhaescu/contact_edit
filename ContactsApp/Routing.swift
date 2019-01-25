import UIKit

enum Routing {
    case editContact
    
    func showScreen() {
        switch self {
        case .editContact:
            let vm = MainViewModel(title: "Employee list", contactList: []) {
                
            }
            
            return
        }
    }
    
}

class Router {
    var topController: UIViewController!
    static let shared = Router()
}
