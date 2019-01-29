import UIKit

public protocol BarButtonType {
    var title: String? { get }
    var buttonStyle: UIBarButtonItem.SystemItem { get }
    var onTapAction: Action { get }
}

class BarButton: BarButtonType {
    var title: String?
    var buttonStyle: UIBarButtonItem.SystemItem
    var onTapAction: Action

    public init(title: String? = nil, buttonStyle: UIBarButtonItem.SystemItem, onTapAction: @escaping Action) {
        self.title = title
        self.buttonStyle = buttonStyle
        self.onTapAction = onTapAction
    }
}

public protocol NavigationBarType {
    var title: String { get }
    var leftButton: BarButtonType? { get }
    var rightButton: BarButtonType? { get }
}

public protocol MainViewModelType: NavigationBarType {
    var delegate: MainViewModelDelegate? { get set }
    var cellViewModels: [ContactsCellViewModelType] { get }
    func didSelectIndex(_ index: Int)
}

public protocol MainViewModelDelegate {
    func reload()
    func didSelectIndex(_ index: Int)
}

final public class MainViewModel: MainViewModelType {
    
    public var cellViewModels: [ContactsCellViewModelType] = [ContactsCellViewModel]()
    public var leftButton: BarButtonType?
    public var rightButton: BarButtonType?
    public var title: String
    
    public var delegate: MainViewModelDelegate?

    public init() {
        self.title = "Contact list"
        self.rightButton = makeRightAction()
        dataSource = [Contact(firstName: "Jim", lastName: "Rohn")]
        buildCellViewModels()
    }
    
    public func didSelectIndex(_ index: Int) {
        var selectedContact = dataSource[index]
        let action: Action = { [weak self] contact in
            guard let self = self,
                let contact = contact else { return }
            selectedContact = contact
            self.buildCellViewModels()
            self.delegate?.reload()
        }
        Router.shared.show(route: .editContact(contact: selectedContact, rightAction: action))
    }
    
    //MARK: - Private Properties
    
    private var dataSource = [Contact]() {
        didSet {
            buildCellViewModels()
            delegate?.reload()
        }
    }
    
    //MARK: - Private Methods
    
    private func makeRightAction() -> BarButtonType {
        let action: Action = { [weak self] contact in
            guard let self = self,
                let contact = contact else { return }
            Router.shared.dismiss()
            self.combineContact(contact)
        }
        return BarButton(buttonStyle: .add) { _ in
            Router.shared.show(route: .newContact(editContact: action))
        }
    }

    private func combineContact(_ contact: Contact) {
        // not sure if works
        guard let index = dataSource.lastIndex(of: contact) else {
            dataSource.append(contact)
            return
        }
        dataSource[index] = contact
    }
    
    private func buildCellViewModels() {
        cellViewModels = dataSource.map({ (contact) -> ContactsCellViewModelType in
            return ContactsCellViewModel(name: contact.firstName + " " + contact.lastName, labelName: "Contact Name")
        })
        
    }
}
