import UIKit

protocol AddContactControllerBDelegate: class {
    func editContact(text: Contact)
    func editContact(contact: Contact)
}

class AddContactViewController: UITableViewController, UITextFieldDelegate {
    
    init(viewModel: NavigationBarType & CollectionType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: AddContactControllerBDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextCell.self, forCellReuseIdentifier: cellID)

        title = viewModel.title
        
        if contactToEdit == nil {
            contactToEdit = Contact()
            makeRightButton()
        }
        if navigationController == nil {
            makeLeftButton()
        }
        makeViewModels(contact: contactToEdit)
    }
    
    private func makeRightButton() {
        guard let rightButton = viewModel.rightButton else {
            return
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: rightButton.buttonStyle, target: self, action: #selector(save))
    }
    
    private func makeLeftButton() {
        guard let leftButton = viewModel.leftButton else {
            return
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: leftButton.buttonStyle, target: self, action: #selector(cancel))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.editContact(contact: contactToEdit ?? Contact())
    }
    
    @objc func cancel() {
        viewModel.leftButton?.onTapAction(nil)
    }
    
    @objc func save() {
        viewModel.rightButton?.onTapAction(contactToEdit)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TextCell,
        let vm = viewModel.cellViewModels[indexPath.row] as? TextCellViewModelType else {
            return UITableViewCell()
        }
        cell.configure(with: vm)
        return cell
    }
    
    //MARK: - Private Properties
    
    private let cellID = "cellID"
    private var contactToEdit: Contact?
    private var viewModels = [TextCellViewModel]()
    
    private var viewModel: NavigationBarType & CollectionType
    
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

extension AddContactViewController: MainViewModelDelegate {
    func reload() {
        tableView.reloadData()
    }
    
    func didSelectIndex(_ index: Int) {
        
    }
}

