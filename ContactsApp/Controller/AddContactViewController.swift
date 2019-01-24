//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Dan  Tatar on 21/01/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import UIKit

protocol AddContactControllerBDelegate: class {
    func addContact(text: Contact)
    func editContact(contact: Contact)
}

class AddContactViewController: UITableViewController, UITextFieldDelegate {
    
    var firstCellID = "FirstCellID"
    var secondCellID = "secondCellID"
    
    var contactToEdit: Contact?
    weak var delegate: AddContactControllerBDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FirstCell.self, forCellReuseIdentifier: firstCellID)
        tableView.register(SecondCell.self, forCellReuseIdentifier: secondCellID)
        
        if let contact = contactToEdit {
            title = "Employee"
        } else {
            title = "New Employee"
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        let index1 = IndexPath(row: 0, section: 0)
        let index2 = IndexPath(row: 1, section: 0)
        let firstCell: FirstCell = self.tableView.cellForRow(at: index1) as! FirstCell
        let secondCell: SecondCell = self.tableView.cellForRow(at: index2) as! SecondCell
        
        guard let firstName = firstCell.firstNameTextField.text,
            let lastName = secondCell.lastNameTextField.text else {
                print("show an error!")
                return
        }
        delegate?.addContact(text: Contact(firstName: firstName, lastName: lastName))
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
    
        guard let oldText = textField.text,
              let stringRange = Range(range, in:oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if let _ = textField.superview as? FirstCell,
            let contact = contactToEdit {
            contact.firstName = newText
            delegate?.editContact(contact: contact)
        }
        
        if let _ = textField.superview as? SecondCell,
            let contact = contactToEdit {
            contact.lastName = newText
            delegate?.editContact(contact: contact)
        }
    
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstCell
            
            cell.firstNameLabel.text = "First name"
            cell.selectionStyle = .none
            cell.firstNameTextField.delegate = self
            if let contact = contactToEdit {
                
                cell.firstNameTextField.text = contact.firstName
                
            }
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondCell
            
            cell2.lastNameLabel.text = "Last name"
            cell2.selectionStyle = .none
            cell2.lastNameTextField.delegate = self
            if let contact = contactToEdit {
                
                cell2.lastNameTextField.text = contact.lastName
                
            }
            return cell2
        }
        return UITableViewCell()
    }
}






