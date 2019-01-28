import UIKit

class ContactsCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        var nl = UILabel()
        nl.font = UIFont.boldSystemFont(ofSize: 23)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    let name: UILabel = {
        var nl = UILabel()
        nl.font = UIFont.boldSystemFont(ofSize: 23)
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: ContactsCellViewModelType) {
        nameLabel.text = viewModel.labelName
        name.text = viewModel.name
    }
    
    func setupViews() {
      
        addSubview(nameLabel)
      
        //constraints nameLabel
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        name.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        name.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}

