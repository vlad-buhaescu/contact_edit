import UIKit

public protocol CellViewModelType {
    func height() -> CGFloat
}

public protocol TextCellViewModelType: CellViewModelType {
    var labelText: String { get }
    var text: String { get }
    var onTextUpdate: (String) -> () { get }
}

public class TextCellViewModel: TextCellViewModelType {
    public var labelText: String
    public var text: String
    public var onTextUpdate: (String) -> ()

    public init(labelText: String,
                text: String,
                onTextUpdate: @escaping (String) -> ()) {
        self.labelText = labelText
        self.text = text
        self.onTextUpdate = onTextUpdate
    }
}

extension TextCellViewModel: CellViewModelType {
    public func height() -> CGFloat {
        return 60
    }
}
