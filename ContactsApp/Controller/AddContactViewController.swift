//
//  AddContactViewController.swift
//  ContactsApp
//
//  Created by Dan  Tatar on 21/01/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import UIKit

protocol AddContactControllerBDelegate: class {
    func addContact(text:String)
}

class AddContactViewController: UITableViewController {
    
    var firstCellID = "FirstCellID"
    var secondCellID = "secondCellID"
    
    weak var delegate: AddContactControllerBDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FirstCell.self, forCellReuseIdentifier: firstCellID)
        tableView.register(SecondCell.self, forCellReuseIdentifier: secondCellID)
        
        navigationItem.title = "New Employee"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        let index1 = IndexPath(row: 0, section: 0)
        let index2 = IndexPath(row: 1, section: 0)
        let firstCell: FirstCell = self.tableView.cellForRow(at: index1) as! FirstCell
        let secondCell: SecondCell = self.tableView.cellForRow(at: index2) as! SecondCell
        let contact = " \(firstCell.firstNameTextField.text!) \(secondCell.lastNameTextField.text!)"
        delegate?.addContact(text: contact)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstCell
            cell.firstNameLabel.text = "First Name"
            cell.firstNameTextField.text = ""
            return cell
            
        } else if indexPath.row == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! SecondCell
            cell2.lastNameLabel.text = "Last Name"
            cell2.lastNameTextField.text = ""
            return cell2
        }
        return UITableViewCell()
    }
}






