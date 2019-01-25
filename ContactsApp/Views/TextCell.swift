import UIKit

public final class TextCell: UITableViewCell {
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    public func configure(with viewModel: TextCellViewModelType) {
        nameTextLabel.text = viewModel.labelText
        nameTextField.text = viewModel.text
        onTextUpdate = viewModel.onTextUpdate
    }
    
    //MARK: - Private Properties
    
    private var onTextUpdate: ((String) -> ())?
    
    private let nameTextLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        var textField = UITextField()
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - Private Methods
    
    private func setupViews() {
        nameTextField.delegate = self
        addSubview(nameTextLabel)
        addSubview(nameTextField)
        
        //constraints firstNameLabel
        nameTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        nameTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        nameTextLabel.rightAnchor.constraint(equalTo: nameTextField.leftAnchor, constant: 10).isActive = true
        nameTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        
        //constraints firstNameTextField
        nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 170).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}

extension TextCell: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText),
            let onTextUpdate = onTextUpdate else {
                return false
        }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        onTextUpdate(newText)
        return true
    }
    
}
