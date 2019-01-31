import UIKit

class BarButton: BarButtonType {
    var title: String?
    var buttonStyle: UIBarButtonItem.SystemItem
    var onTapAction: Action
    
    public init(title: String? = nil, buttonStyle: UIBarButtonItem.SystemItem, onTapAction: @escaping Action) {
        self.title = title
        self.buttonStyle = buttonStyle
        self.onTapAction = onTapAction
    }
}

extension BarButton: Equatable {
    static func == (lhs: BarButton, rhs: BarButton) -> Bool {
        return lhs.buttonStyle == rhs.buttonStyle &&
               lhs.title == rhs.title &&
            lhs.onTapAction == rhs.onTapAction
    }
}
