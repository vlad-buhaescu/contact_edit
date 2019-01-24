//
//  Contact.swift
//  ContactsApp
//
//  Created by Dan  Tatar on 21/01/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import Foundation

class Contact: NSObject {
    
    var firstName: String
    var lastName: String

    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
