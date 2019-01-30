import UIKit

class ContactsCell: UITableViewCell {
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Properties
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let name: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Private Methods
    
    func setupViews() {
        selectionStyle = .none
        addSubview(nameLabel)
        addSubview(name)
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        name.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        name.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}

extension ContactsCell: Configurable {
    func configure(with viewModel: CellViewModelType) {
        guard let viewModel = viewModel as? ContactsCellViewModelType else {
            return
        }
        nameLabel.text = viewModel.labelName
        name.text = viewModel.name
    }
}
