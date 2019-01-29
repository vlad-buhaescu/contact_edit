import Foundation

protocol CollectionType {
    var cellViewModels: [CellViewModelType] { get }
    var delegate: MainViewModelDelegate? { get set }
}

protocol EditContactViewModelType: NavigationBarType, CollectionType {
    var contactToEdit: Contact { get }
}

class EditContactViewModel: EditContactViewModelType {
    var cellViewModels: [CellViewModelType] = [TextCellViewModel]()
    var title: String
    var leftButton: BarButtonType?
    var rightButton: BarButtonType?
    var contactToEdit: Contact
    var delegate: MainViewModelDelegate?

    public init(rightAction: @escaping Action, contactToEdit: Contact) {
        self.title = "Edit contact"
        self.contactToEdit = contactToEdit
        self.leftButton = makeLeftButton()
        self.rightButton = makeRightButton(rightAction)
        buildCellViewModels()
    }
    
    //MARK: - Private Methods
    
    private func makeRightButton(_ rightAction: @escaping Action) -> BarButtonType {
        return BarButton(buttonStyle: .save, onTapAction: rightAction)
    }
    
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
