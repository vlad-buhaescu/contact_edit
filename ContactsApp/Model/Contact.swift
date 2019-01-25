import Foundation

public class Contact: NSObject {
    var firstName: String
    var lastName: String

    public override init() {
        self.firstName = ""
        self.lastName = ""
    }
    
    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
