import Foundation

//enum CellType: CaseIterable {
public enum CellType: CaseIterable {
    case firstName
    case lastName
}

public protocol TextCellViewModelType {
    var labelText: String { get }
    var text: String { get }
    var type: CellType { get }
    var onTextUpdate: (String) -> () { get }
}

public class TextCellViewModel: TextCellViewModelType {
    public var labelText: String
    
    public var text: String
    
    public var type: CellType
    
    public var onTextUpdate: (String) -> ()

    public init(labelText: String, text: String, type: CellType, onTextUpdate: @escaping (String) -> ()) {
        self.labelText = labelText
        self.text = text
        self.type = type
        self.onTextUpdate = onTextUpdate
    }
}
