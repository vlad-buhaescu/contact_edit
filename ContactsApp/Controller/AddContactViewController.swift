import UIKit

protocol AddContactControllerBDelegate: class {
    func addContact(text: Contact)
    func editContact(contact: Contact)
}

class AddContactViewController: UITableViewController, UITextFieldDelegate {
    
//    convenience init(contactToEdit: Contact?) {
//        self.init(nibName: nil, bundle: nil)
//        self.contactToEdit = contactToEdit
//    }
    init(viewModel: AddContactViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
            title = "New Employee"
            makeRightButton()
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
        guard let leftButton = viewModel.rightButton else {
            return
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: leftButton.buttonStyle, target: self, action: #selector(cancel))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.editContact(contact: contactToEdit ?? Contact())
    }
    
    @objc func cancel() {
        viewModel.leftButton?.onTapAction()
    }
    
    @objc func save() {
        delegate?.addContact(text: contactToEdit ?? Contact())
        viewModel.rightButton?.onTapAction()
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
    
    private var viewModel: AddContactViewModelType
    
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


