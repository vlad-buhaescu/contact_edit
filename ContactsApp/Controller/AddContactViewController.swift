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
    func editContact(text: Contact)
}

class AddContactViewController: UITableViewController, UITextFieldDelegate {
    
    var firstCellID = "FirstCellID"
    var secondCellID = "secondCellID"
    var cell = FirstCell()

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
        let cont = Contact()
        
        let contact = " \(firstCell.firstNameTextField.text!) \(secondCell.lastNameTextField.text!)"
        cont.name = contact
        delegate?.addContact(text: cont)
        
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell1 = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstCell
        let oldText = cell1.firstNameTextField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
                                                  
        return true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            if let contact = contactToEdit {
            let indexPath = IndexPath(row: 0, section: 0)
            let cell1 = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstCell
                contact.name = cell1.firstNameTextField.text!
                  delegate?.editContact(text: contact)
                print("contaact to edit is \(contact.name)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstCell
            cell.firstNameLabel.text = "First name"
              cell.selectionStyle = .none
            if let contact = contactToEdit {
            cell.firstNameTextField.text = contact.name
          
            }
            return cell
            
        } else if indexPath.row == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondCell
            cell2.lastNameLabel.text = "Last name"
//            cell2.lastNameTextField.text = ""
            cell2.selectionStyle = .none
            return cell2
        }
        return UITableViewCell()
    }
}






