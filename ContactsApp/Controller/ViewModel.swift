import UIKit

public protocol BarButtonType {
    var title: String? { get }
    var buttonStyle: UIBarButtonItem.SystemItem { get }
    var onTapAction: () -> () { get }
}

class BarButton: BarButtonType {
    var title: String?
    var buttonStyle: UIBarButtonItem.SystemItem
    var onTapAction: () -> ()

    public init(title: String? = nil, buttonStyle: UIBarButtonItem.SystemItem, onTapAction: @escaping () -> ()) {
        self.title = title
        self.buttonStyle = buttonStyle
        self.onTapAction = onTapAction
    }
}

public protocol NavigationBarType {
    var title: String { get }
    var leftButton: BarButtonType? { get }
    var rightButton: BarButtonType? { get }
}

public protocol MainViewModelType: NavigationBarType {

}

final public class MainViewModel: MainViewModelType {
    public var title: String
    public var rightButton: BarButtonType?
    public var leftButton: BarButtonType? = nil

    public init(title: String, rightButton: BarButtonType?, leftButton: BarButtonType? = nil) {
        self.title = title
        self.rightButton = rightButton
        self.leftButton = leftButton
    }
    
    //MARK: - Private Properties
    
    private var dataSource = [Contact]()
    
}
