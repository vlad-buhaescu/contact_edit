import UIKit

class ConstactsListViewController: UITableViewController, AddContactControllerBDelegate, UITextFieldDelegate {
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: MainViewModelType
    
    var contacts = [Contact]()
    var contactID = "contactID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = viewModel.title
        tableView.register(ContactsCell.self, forCellReuseIdentifier: contactID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addName))
    }
    
    @objc func addName() {
        viewModel.rightButton?.onTapAction()
//        let addContactViewController = AddContactViewController()
//        addContactViewController.delegate = self
//        let navigationController = UINavigationController(rootViewController: addContactViewController)
//        present(navigationController, animated: true)
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
        if let selectedRow = tableView.indexPathForSelectedRow {
//            let addContactViewController = AddContactViewController(contactToEdit: contacts[selectedRow.row])
//            addContactViewController.delegate = self
//            navigationController?.pushViewController(addContactViewController, animated: true)
        }
    }
}
