import UIKit

class ConstactsListViewController: UITableViewController, AddContactControllerBDelegate, UITextFieldDelegate {
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: MainViewModelType
    
    var contacts = [Contact]()
    var contactID = "contactID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = viewModel.title
        tableView.register(ContactsCell.self, forCellReuseIdentifier: contactID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addName))
        navigationItem.backBarButtonItem = nil
    }
    
    @objc func addName() {
        viewModel.rightButton?.onTapAction(nil)
    }
    
    func editContact(contact: Contact) {
        if let index = contacts.index(of: contact) {
            contacts[index] = contact
            tableView.reloadData()
        }
    }
    
    func editContact(text: Contact) {
        let newRowIndex = contacts.count
        contacts.append(text)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellViewModels[indexPath.row].height()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contactID, for: indexPath) as? ContactsCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectIndex(indexPath.row)
    }
}

extension ConstactsListViewController: MainViewModelDelegate {
    
    func reload() {
        tableView.reloadData()
    }
    
    func didSelectIndex(_ index: Int) {
        
    }
}
