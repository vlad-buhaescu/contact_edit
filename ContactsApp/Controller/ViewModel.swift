import Foundation

public protocol MainViewModelType {
//    var title: String { get }
//    var contactList: [Contact] { get }
//    var onAddTap: () -> () { get }
}

final public class MainViewModel: MainViewModelType {
    
    public init() {
        self.title = ""
        self.contactList = [Contact]()
        self.onAddTap = onAddTap
    }
    
    //MARK: - Private Properties
    
    private var title: String
    private var contactList: [Contact]
    private var onAddTap: () -> ()

}
