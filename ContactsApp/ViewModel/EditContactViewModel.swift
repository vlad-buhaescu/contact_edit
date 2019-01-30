import Foundation

public protocol CollectionType {
    var cellViewModels: [CellViewModelType] { get }
    var delegate: MainViewModelDelegate? { get set }
    func onTapSaveAction()
}

public protocol EditContactViewModelType: NavigationBarType, CollectionType {
    var contactToEdit: Contact { get }
    var saveAction: Action { get }
}

final class EditContactViewModel: EditContactViewModelType {
    var cellViewModels: [CellViewModelType] = [TextCellViewModel]()
    var title: String
    var leftButton: BarButtonType?
    var rightButton: BarButtonType?
    var contactToEdit: Contact
    var delegate: MainViewModelDelegate?
    var saveAction: Action
    
    public init(saveAction: @escaping Action, contactToEdit: Contact) {
        self.title = "Edit contact"
        self.contactToEdit = contactToEdit
        self.saveAction = saveAction
        self.leftButton = makeLeftButton()
        buildCellViewModels()
    }
    
    public func onTapSaveAction() {
        saveAction(contactToEdit)
    }
    
    public func cancelAction() {
        Router.shared.dismiss()
    }
  
    //MARK: - Private Methods
    
    private func makeLeftButton() -> BarButtonType {
        return BarButton(buttonStyle: .cancel, onTapAction: { (contact) in
            Router.shared.dismiss()
        })
    }
    
    private func buildCellViewModels() {
        let firstNameViewModel = TextCellViewModel(labelText: "First name",
                                                   text: contactToEdit.firstName) { [weak self] (newText) in
                                                    guard let self = self else { return }
                                                    self.contactToEdit.firstName = newText
        }
        let lastNameViewModel = TextCellViewModel(labelText: "Last name",
                                                  text: contactToEdit.lastName) { [weak self] (newText) in
                                                    guard let self = self else { return }
                                                    self.contactToEdit.lastName = newText
        }
        cellViewModels = [firstNameViewModel, lastNameViewModel]
        delegate?.reload()
    }
}
