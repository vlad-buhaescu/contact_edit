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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = viewModel.title
        tableView.register(ContactsCell.self, forCellReuseIdentifier: ContactsCellViewModel.identifier)
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCellViewModel.identifier)
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if viewModel is EditContactViewModelType {
            viewModel.onTapSaveAction()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard viewModel is MainViewModelType else {
            return
        }
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //MARK: - Private Properties
    
    private var viewModel: CollectionType & NavigationBarType
    
    //MARK: - Private Methods
    
    private func setupView() {
        if viewModel is NewContactViewModelType {
            makeLeftButton()
            makeRightButton()
            tableView.allowsSelection = false
        }
        
        if let vm = viewModel as? MainViewModelType,
            let button = vm.rightButton {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: button.buttonStyle, target: self, action: #selector(addName))
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
        viewModel.onTapSaveAction()
    }
    
    @objc func addName() {
        viewModel.rightButton?.onTapAction(nil)
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellViewModels[indexPath.row].height()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.cellViewModels[indexPath.row]
        return vm.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete,
            let vm = viewModel as? MainViewModelType {
            vm.deleteAtIndex(indexPath.row)
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
}
