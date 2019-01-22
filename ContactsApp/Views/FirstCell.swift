//
//  File.swift
//  ContactsApp
//
//  Created by Dan  Tatar on 21/01/2019.
//  Copyright © 2019 Dany. All rights reserved.
//

import UIKit

class FirstCell: UITableViewCell {
    
    let firstNameLabel: UILabel = {
        var fn = UILabel()
        fn.font = UIFont.systemFont(ofSize: 20)
        fn.translatesAutoresizingMaskIntoConstraints = false
        return fn
    }()
    
    let firstNameTextField: UITextField = {
        var fn = UITextField()
        fn.layer.cornerRadius = 4
        fn.layer.borderWidth = 0.5
        fn.layer.borderColor = UIColor.gray.cgColor
        fn.translatesAutoresizingMaskIntoConstraints = false
        return fn
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
        
        addSubview(firstNameLabel)
        addSubview(firstNameTextField)
        
        //constraints firstNameLabel
        firstNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        firstNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        firstNameLabel.rightAnchor.constraint(equalTo: firstNameTextField.leftAnchor, constant: 10).isActive = true
        firstNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        
        //constraints firstNameTextField
        firstNameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        firstNameTextField.widthAnchor.constraint(equalToConstant: 170).isActive = true
        firstNameTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        firstNameTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}

