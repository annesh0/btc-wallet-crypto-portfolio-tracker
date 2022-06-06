//
//  EditorController.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 6/5/22.
//

import UIKit

class EditorController: UIViewController {
    
    var nameField = UITextField()
    var aboutField = UITextField()
    var saveButton = UIButton()
    var parentController: ViewController?
    
    override func viewDidLoad() {
        title = "Editor"
        view.backgroundColor = .white
        
        nameField.placeholder = "Enter Name"
        nameField.textColor = .black
        nameField.font = .systemFont(ofSize: 20, weight: .bold)
        nameField.backgroundColor = .lightGray
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        
        aboutField.placeholder = "Enter Bio"
        aboutField.textColor = .black
        aboutField.font = .systemFont(ofSize: 20)
        aboutField.backgroundColor = .lightGray
        aboutField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutField)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(save), for: .allTouchEvents)
        view.addSubview(saveButton)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameField.widthAnchor.constraint(equalToConstant: 200),
            nameField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            aboutField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            aboutField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutField.widthAnchor.constraint(equalToConstant: 200),
            aboutField.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.topAnchor.constraint(equalTo: aboutField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func save() {
        guard let name = nameField.text, !name.isEmpty else { showAlert(); return}
        parentController?.nameLabel.text = name
        guard let about = aboutField.text, !about.isEmpty else { showAlert(); return}
        parentController?.aboutLabel.text = about
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        
    }
    
    
}
