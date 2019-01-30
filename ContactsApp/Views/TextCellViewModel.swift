import UIKit

public protocol CellViewModelType {
    static var identifier: String { get }
    func height() -> CGFloat
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol Configurable {
    func configure(with viewModel: CellViewModelType)
}

extension CellViewModelType {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: self).identifier, for: indexPath)
        if let c = cell as? Configurable {
            c.configure(with: self)
        }
        return cell
    }
}

extension CellViewModelType {
    public static var identifier: String {
        return String(describing: self)
    }
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
