//
//  ViewController.swift
//  ExampleP3
//
//  Created by Dylan McCreesh on 6/3/22.
//

import UIKit

class ViewController: UIViewController {

    var titleLabel = UILabel()
    var image = UIImageView()
    var confirmButton = UIButton()
    var itemInput = UITextField()
    var quantityInput = UITextField()
    var header = UILabel()
    var shoppingList = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        titleLabel.text = "Shopping List"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        image.image = UIImage(named: "shopping cart")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        confirmButton.setTitle(" Add ", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.systemBlue.cgColor
        confirmButton.layer.cornerRadius = 10
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        view.addSubview(confirmButton)
        
        itemInput.placeholder = "Item"
        itemInput.textColor = .black
        itemInput.font = .systemFont(ofSize: 12)
        itemInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemInput)
        
        quantityInput.placeholder = "Quantity"
        quantityInput.textColor = .black
        quantityInput.font = .systemFont(ofSize: 12)
        quantityInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityInput)
        
        header.text = "My List:"
        header.textColor = .black
        header.font = .systemFont(ofSize: 15, weight: .bold)
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        
        shoppingList.textColor = .black
        shoppingList.font = .systemFont(ofSize: 15)
        shoppingList.translatesAutoresizingMaskIntoConstraints = false
        shoppingList.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.00)
        shoppingList.text = ""
        shoppingList.isScrollEnabled = true
        shoppingList.isEditable = false
        view.addSubview(shoppingList)
        
        setupConstraints()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 120),
            image.heightAnchor.constraint(equalToConstant: 120)])
        
        NSLayoutConstraint.activate([
            itemInput.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            itemInput.centerXAnchor.constraint(equalTo: image.centerXAnchor)])
        
        NSLayoutConstraint.activate([
            quantityInput.topAnchor.constraint(equalTo: itemInput.bottomAnchor, constant: 20),
            quantityInput.centerXAnchor.constraint(equalTo: itemInput.centerXAnchor)])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: quantityInput.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: quantityInput.centerXAnchor)])
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20),
            header.centerXAnchor.constraint(equalTo: confirmButton.centerXAnchor)])
        
        NSLayoutConstraint.activate([
            shoppingList.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            shoppingList.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            shoppingList.widthAnchor.constraint(equalToConstant: 300),
            shoppingList.heightAnchor.constraint(equalToConstant: 400)])
    }

    @objc func buttonClick(){
        if(itemInput.text != "" && quantityInput.text != "") {
            
            shoppingList.text += "-" + itemInput.text! + " (" + quantityInput.text! + ")\n"
            itemInput.text = ""
            quantityInput.text = ""
        }
    }
}

