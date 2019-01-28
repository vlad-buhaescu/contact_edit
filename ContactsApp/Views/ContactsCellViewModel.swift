import Foundation

protocol ContactsCellViewModelType {
    var labelName: String { get }
    var name: String { get }
}

class ContactsCellViewModel: ContactsCellViewModelType {
    var name: String
    var labelName: String

    public init(name: String, labelName: String) {
        self.name = name
        self.labelName = labelName
    }
}

