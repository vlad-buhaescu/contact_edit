import UIKit

public protocol ContactsCellViewModelType: CellViewModelType {
    var labelName: String { get }
    var name: String { get }
}

public class ContactsCellViewModel: ContactsCellViewModelType {
    public var name: String
    public var labelName: String
    
    public init(name: String, labelName: String) {
        self.name = name
        self.labelName = labelName
    }
}
