import Foundation

protocol NewContactViewModelType: NavigationBarType, CollectionType {
}

final class NewContactViewModel: NewContactViewModelType {
    
    var title: String
    var leftButton: BarButtonType?
    var rightButton: BarButtonType?
    var cellViewModels: [CellViewModelType] = [TextCellViewModel]()
    var delegate: MainViewModelDelegate?
    
    public init(rightAction: @escaping Action) {
        self.title = "New contact"
        self.rightAction = rightAction
        self.rightButton = makeRightButton()
        self.leftButton = makeLeftButton()
        buildCellViewModels()
    }
    
    func onTapSaveAction() {
        rightAction(newContact)
    }
    
    //MARK: - Private Properties
    
    private var rightAction: Action
    private var newContact = Contact()
    
    //MARK: - Public Methods
    
    private func makeRightButton() -> BarButtonType {
        return BarButton(buttonStyle: .save, onTapAction: rightAction)
    }
    
    private func makeLeftButton() -> BarButtonType {
        return BarButton(buttonStyle: .cancel, onTapAction: { _ in
            Router.shared.dismiss()
        })
    }
    
    private func buildCellViewModels() {
        let firstNameViewModel = TextCellViewModel(labelText: "First name",
                                                   text: "") { [weak self] (newText) in
                                                    guard let self = self else { return }
                                                    self.newContact.firstName = newText
        }
        let lastNameViewModel = TextCellViewModel(labelText: "Last name",
                                                  text: "") { [weak self] (newText) in
                                                    guard let self = self else { return }
                                                    self.newContact.lastName = newText
        }
        cellViewModels = [firstNameViewModel, lastNameViewModel]
        delegate?.reload()
    }
}
