//
//  ViewController.swift
//  ContactsApp
//
//  Created by Dan  Tatar on 21/01/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, AddContactControllerBDelegate, UITextFieldDelegate {
  
    var contacts = [Contact]()
    var contactID = "contactID"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Employees"
        tableView.register(ContactsCell.self, forCellReuseIdentifier: contactID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addName))
    }
    
    @objc func addName() {
        let addContactViewController = AddContactViewController()
        addContactViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: addContactViewController)
        self.present(navigationController, animated: true)
    }
    
    func editContact(contact: Contact) {
        if let index = contacts.index(of: contact) {
            contacts[index] = contact
             tableView.reloadData()
        }
    }
 
    func addContact(text: Contact) {
        let newRowIndex = contacts.count
        contacts.append(text)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: contactID, for: indexPath) as! ContactsCell
        cell.selectionStyle = .none
        cell.nameLabel.text = item.firstName + " " + item.lastName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        contacts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
     }
  }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addContactViewController = AddContactViewController()
        addContactViewController.delegate = self
        if let selectedRow = tableView.indexPathForSelectedRow {
//            addContactViewController.contactToEdit = contacts[selectedRow.row]
    }
        navigationController?.pushViewController( addContactViewController, animated: true)
  }
}
