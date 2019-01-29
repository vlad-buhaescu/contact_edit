import UIKit

class AddContactViewController: UITableViewController, UITextFieldDelegate {
    
    init(viewModel: NavigationBarType & CollectionType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TextCell.self, forCellReuseIdentifier: cellID)
        title = viewModel.title
    
        if viewModel is NewContactViewModelType {
            makeLeftButton()
            makeRightButton()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if viewModel is EditContactViewModelType {
            viewModel.saveAction()
        }
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
    
    @objc func cancel() {
        viewModel.leftButton?.onTapAction(nil)
    }
    
    @objc func save() {
        viewModel.saveAction()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
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
//    private var contactToEdit: Contact?
    private var viewModels = [TextCellViewModel]()
    
    private var viewModel: NavigationBarType & CollectionType
}

extension AddContactViewController: MainViewModelDelegate {
    func reload() {
        tableView.reloadData()
    }
    
    func didSelectIndex(_ index: Int) {
        
    }
}

