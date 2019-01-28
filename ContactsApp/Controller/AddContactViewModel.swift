import Foundation

protocol AddContactViewModelType: NavigationBarType {
    var contactToEdit: Contact? { get }
}

class AddContactViewModel: AddContactViewModelType {
    var title: String
    var leftButton: BarButtonType?
    var rightButton: BarButtonType?
    var contactToEdit: Contact?

    public init(leftButton: BarButtonType?, contactToEdit: Contact?) {
        self.title = "Edit contact"
        self.leftButton = makeLeftButton()
        self.rightButton = makeRightButton()
        self.contactToEdit = contactToEdit
    }
    
    //MARK: - Public Methods
    
    private func makeRightButton() -> BarButtonType {
        return BarButton(buttonStyle: .save, onTapAction: { (contact) in
            print("tap")
            
        })
    }
    
    private func makeLeftButton() -> BarButtonType {
        return BarButton(buttonStyle: .save, onTapAction: { (contact) in
            print("tap")
            Router.shared.dismiss()
        })
    }
}
