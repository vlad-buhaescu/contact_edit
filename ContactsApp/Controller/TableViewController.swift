import UIKit

class TableViewController: UITableViewController {
    
    init(viewModel: CollectionType & NavigationBarType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: CollectionType & NavigationBarType
    
    var contacts = [Contact]()
    var contactID = "contactID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = viewModel.title
        tableView.register(ContactsCell.self, forCellReuseIdentifier: ContactsCellViewModel.identifier)
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCellViewModel.identifier)
//        tableView.register(ContactsCell.self, forCellReuseIdentifier: ContactsCellViewModel.identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addName))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
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
        
        if let vm = viewModel.cellViewModels[indexPath.row] as? ContactsCellViewModelType {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactsCellViewModel.identifier, for: indexPath) as? ContactsCell else {
                return UITableViewCell()
            }
            cell.configure(with: vm)
            return cell
        }
        
        if let vm = viewModel.cellViewModels[indexPath.row] as? TextCellViewModelType {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextCellViewModel.identifier, for: indexPath) as? TextCell else {
                return UITableViewCell()
            }
            cell.configure(with: vm)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vm = viewModel as? MainViewModelType {
            vm.didSelectIndex(indexPath.row)
        }
    }
}

extension TableViewController: MainViewModelDelegate {
    
    func reload() {
        tableView.reloadData()
    }
    
    func didSelectIndex(_ index: Int) {
        
    }
}
