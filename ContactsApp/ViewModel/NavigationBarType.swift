import UIKit

public protocol BarButtonType {
    var title: String? { get }
    var buttonStyle: UIBarButtonItem.SystemItem { get }
    var onTapAction: Action { get }
}

public protocol NavigationBarType {
    var title: String { get }
    var leftButton: BarButtonType? { get }
    var rightButton: BarButtonType? { get }
}
