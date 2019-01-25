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
    
    convenience init(contactToEdit: Contact?) {
        self.init(nibName: nil, bundle: nil)
        self.contactToEdit = contactToEdit
    }
    
    weak var delegate: AddContactControllerBDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextCell.self, forCellReuseIdentifier: cellID)
        
        if let contact = contactToEdit {
            title = "Employee"
            makeViewModels(contact: contact)
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
        //        let index1 = IndexPath(row: 0, section: 0)
        //        let index2 = IndexPath(row: 1, section: 0)
        //        let firstCell: FirstCell = self.tableView.cellForRow(at: index1) as! FirstCell
        //        let secondCell: SecondCell = self.tableView.cellForRow(at: index2) as! SecondCell
        //
        //        guard let firstName = firstCell.firstNameTextField.text,
        //            let lastName = secondCell.lastNameTextField.text else {
        //                print("Text field issue")
        //                return
        //        }
        //        delegate?.addContact(text: Contact(firstName: firstName, lastName: lastName))
        //
        dismiss(animated: true, completion: nil)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let oldText = textField.text,
//            let stringRange = Range(range, in:oldText) else {
//                return false
//        }
//
//        let newText = oldText.replacingCharacters(in: stringRange, with: string)
//        //        if let _ = textField.superview as? FirstCell,
//        //            let contact = contactToEdit {
//        //            contact.firstName = newText
//        //            delegate?.editContact(contact: contact)
//        //        }
//        //
//        //        if let _ = textField.superview as? SecondCell,
//        //            let contact = contactToEdit {
//        //            contact.lastName = newText
//        //            delegate?.editContact(contact: contact)
//        //        }
//
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TextCell,
            viewModels.count < indexPath.row else {
                return UITableViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return UITableViewCell()
    }
    
    //MARK: - Private Properties
    
    private let cellID = "cellID"
    private var contactToEdit: Contact?
    private var viewModels = [TextCellViewModel]()
    
    //MARK: - Private Methods
    
    private func makeViewModels(contact: Contact) {
        let firstNameViewModel = TextCellViewModel(labelText: "First name",
                                                   text: contact.firstName,
                                                   type: .firstName) { [weak self] in
                                                    guard let self = self,
                                                        let contactToEdit = self.contactToEdit else { return }
                                                    contactToEdit.firstName = "new future delivered text"
        }
        let lastNameViewModel = TextCellViewModel(labelText: "Last name",
                                                  text: contact.lastName,
                                                  type: .lastName) { [weak self] in
                                                    guard let self = self,
                                                        let contactToEdit = self.contactToEdit else { return }
                                                    contactToEdit.lastName = "new future delivered text lN"
        }
        viewModels = [firstNameViewModel, lastNameViewModel]
        tableView.reloadData()
    }
    
}


