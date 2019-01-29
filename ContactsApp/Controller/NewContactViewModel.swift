import Foundation

protocol NewContactViewModelType: NavigationBarType, CollectionType {
}

class NewContactViewModel: NewContactViewModelType {
    var cellViewModels: [CellViewModelType] = [TextCellViewModel]()
    var delegate: MainViewModelDelegate?
    
    var title: String
    var leftButton: BarButtonType?
    var rightButton: BarButtonType?
    
    public init(rightAction: Action?) {
        self.title = "New contact"
        self.rightAction = rightAction
        self.rightButton = makeRightButton()
    }
    
    //MARK: - Private Properties
    
    private var rightAction: Action?
    
    //MARK: - Public Methods
    
    private func makeRightButton() -> BarButtonType? {
        guard let rightAction = rightAction else { return nil }
        return BarButton(buttonStyle: .save, onTapAction: rightAction)
    }
    
    private func makeLeftButton() -> BarButtonType {
        return BarButton(buttonStyle: .save, onTapAction: { (contact) in
            print("tap")
            Router.shared.dismiss()
        })
    }
}
