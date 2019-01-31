import UIKit

public protocol MainViewModelType: NavigationBarType, CollectionType {
    func didSelectIndex(_ index: Int)
    func deleteAtIndex(_ index: Int)
}

public protocol MainViewModelDelegate {
    func reload()
}

extension MainViewModelDelegate {
    func didSelectIndex(_ index: Int) {}
}

final public class MainViewModel: MainViewModelType {
    
    
    public var cellViewModels: [CellViewModelType] = [ContactsCellViewModel]()
    public var leftButton: BarButtonType?
    public var rightButton: BarButtonType?
    public var title: String
    
    public var delegate: MainViewModelDelegate?
    public func onTapSaveAction() {}
    
    public init(contacts: [Contact] = []) {
        self.title = "Contact list"
        self.rightButton = makeRightAction()
        self.dataSource = contacts
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
    
    public func deleteAtIndex(_ index: Int) {
        dataSource.remove(at: index)
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
            Router.shared.show(route: .newContact(saveAction: action))
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
