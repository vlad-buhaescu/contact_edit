//
//  SecondCell.swift
//  ContactsApp
//
//  Created by Dan  Tatar on 21/01/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import UIKit

class SecondCell: UITableViewCell {
    
    let lastNameLabel: UILabel = {
        var ln = UILabel()
        ln.font = UIFont.systemFont(ofSize: 20)
        ln.translatesAutoresizingMaskIntoConstraints = false
        return ln
    }()
    
    let lastNameTextField: UITextField = {
        var ln = UITextField()
        ln.layer.cornerRadius = 4
        ln.layer.borderWidth = 0.5
        ln.layer.borderColor = UIColor.gray.cgColor
        ln.translatesAutoresizingMaskIntoConstraints = false
        return ln
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(lastNameLabel)
        addSubview(lastNameTextField)
        
        //constraints lastNameLabel
        lastNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        lastNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        lastNameLabel.rightAnchor.constraint(equalTo: lastNameTextField.leftAnchor, constant: 10).isActive = true
        lastNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        
        //constraints lastNameLabel
        lastNameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        lastNameTextField.widthAnchor.constraint(equalToConstant: 170).isActive = true
        lastNameTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        lastNameTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}
