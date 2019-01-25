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
        
        if let _ = contactToEdit {
            title = "Employee"
        } else {
            contactToEdit = Contact()
            title = "New Employee"
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        }
        makeViewModels(contact: contactToEdit)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.editContact(contact: contactToEdit ?? Contact())
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func save() {
        delegate?.addContact(text: contactToEdit ?? Contact())
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TextCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    //MARK: - Private Properties
    
    private let cellID = "cellID"
    private var contactToEdit: Contact?
    private var viewModels = [TextCellViewModel]()
    
    //MARK: - Private Methods
    
    private func makeViewModels(contact: Contact?) {
        let firstNameViewModel = TextCellViewModel(labelText: "First name",
                                                   text: contact?.firstName ?? "") { (newText) in
                                                    contact?.firstName = newText
        }
        let lastNameViewModel = TextCellViewModel(labelText: "Last name",
                                                  text: contact?.lastName ?? "") { (newText) in
                                                    contact?.lastName = newText
        }
        viewModels = [firstNameViewModel, lastNameViewModel]
        tableView.reloadData()
    }
}


