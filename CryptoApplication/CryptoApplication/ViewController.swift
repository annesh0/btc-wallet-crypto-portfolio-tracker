//
//  ViewController.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 5/23/22.
//

import UIKit

class ViewController: UIViewController {

    var nameLabel = UILabel()
    var shoppingImageView = UIImageView()
    var itemTextField = UITextField()
    var quantityTextField = UITextField()
    var listTextView = UITextView()
    var addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        nameLabel.text = "Shopping List"
        nameLabel.textColor = .darkGray
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        shoppingImageView.image = UIImage(named: "cartImage")
        shoppingImageView.contentMode = .scaleAspectFill
        shoppingImageView.clipsToBounds = true
        shoppingImageView.layer.cornerRadius = 5
        shoppingImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shoppingImageView)
        
        itemTextField.placeholder = "Item"
        itemTextField.textColor = .black
        itemTextField.font = .systemFont(ofSize: 15)
        itemTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemTextField)
        
        quantityTextField.placeholder = "Quantity"
        quantityTextField.textColor = .black
        quantityTextField.font = .systemFont(ofSize: 15)
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityTextField)
        
        addButton.setTitle(" Add ", for: .normal)
        addButton.setTitleColor(.systemBlue, for: .normal)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        addButton.layer.cornerRadius = 10
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(onAddButtonPress), for: .touchUpInside)
        view.addSubview(addButton )
        
        listTextView.textColor = .black
        listTextView.font = .systemFont(ofSize: 15)
        listTextView.translatesAutoresizingMaskIntoConstraints = false
        listTextView.backgroundColor = .lightGray
        listTextView.text = ""
        listTextView.isScrollEnabled = false
        view.addSubview(listTextView)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: shoppingImageView.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            shoppingImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            shoppingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shoppingImageView.widthAnchor.constraint(equalToConstant: 200),
            shoppingImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            itemTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 20),
            itemTextField.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            quantityTextField.topAnchor.constraint(equalTo: itemTextField.bottomAnchor,constant: 10),
            quantityTextField.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: quantityTextField.bottomAnchor,constant: 10),
            addButton.centerXAnchor.constraint(equalTo: quantityTextField.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            listTextView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            listTextView.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            listTextView.heightAnchor.constraint(equalToConstant: 200),
            listTextView.widthAnchor.constraint(equalToConstant: 200)
        ])

    }
    
    @objc func onAddButtonPress() {
        if(itemTextField.text != nil && quantityTextField.text != nil) {
            
            listTextView.text += itemTextField.text! + " " + quantityTextField.text! + "\n"
            itemTextField.text = ""
            quantityTextField.text = ""
        }
    }


}

