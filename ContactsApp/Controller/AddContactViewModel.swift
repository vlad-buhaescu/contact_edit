import Foundation

protocol AddContactViewModelType: NavigationBarType {
    var contactToEdit: Contact? { get }
}

class AddContactViewModel: AddContactViewModelType {
    var title: String
    var leftButton: BarButtonType?
    var rightButton: BarButtonType?
    var contactToEdit: Contact?

    public init(title: String, leftButton: BarButtonType?, rightButton: BarButtonType?, contactToEdit: Contact?) {
        self.title = title
        self.leftButton = leftButton
        self.rightButton = rightButton
        self.contactToEdit = contactToEdit
    }
}
