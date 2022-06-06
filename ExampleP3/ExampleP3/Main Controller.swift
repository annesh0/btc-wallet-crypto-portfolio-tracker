//
//  MainController.swift
//  Navigation
//
//  Created by Dylan McCreesh on 6/5/22.
//

import UIKit

class MainController: UIViewController {
    
    var nameInput = UITextField()
    var aboutMeLabel = UILabel()
    var aboutMeInput = UITextView()
    var birthdayInput = UITextField()
    var contactInput = UITextField()
    var saveButton = UIButton()
    weak var parentController: ViewController?
    
    override func viewDidLoad() {
        title = "Edit Profile"
        view.backgroundColor = .white
        
        nameInput.placeholder = "Enter Name (Required)"
        nameInput.textColor = .black
        nameInput.font = .systemFont(ofSize: 15, weight: .regular)
        nameInput.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.00)
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameInput)
        
        aboutMeInput.textColor = .black
        aboutMeInput.font = .systemFont(ofSize: 15)
        aboutMeInput.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.00)
        aboutMeInput.isEditable = true
        aboutMeInput.isScrollEnabled = true
        aboutMeInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutMeInput)
        
        aboutMeLabel.text = "Enter About Me:"
        aboutMeLabel.textColor = .black
        aboutMeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutMeLabel)
        
        birthdayInput.placeholder = "Enter Birthday"
        birthdayInput.textColor = .black
        birthdayInput.font = .systemFont(ofSize: 15, weight: .regular)
        birthdayInput.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.00)
        birthdayInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(birthdayInput)
        
        contactInput.placeholder = "Enter Contact Info"
        contactInput.textColor = .black
        contactInput.font = .systemFont(ofSize: 15)
        contactInput.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.00)
        contactInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contactInput)
        
        saveButton.setTitle("  Save  ", for: .normal)
        saveButton.backgroundColor = (UIColor(red: 155/255, green: 155/255, blue: 255/255, alpha: 1.0))
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(save), for: .allTouchEvents)
        saveButton.layer.cornerRadius = 15
        view.addSubview(saveButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            nameInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameInput.widthAnchor.constraint(equalToConstant: 200),
            nameInput.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            birthdayInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 20),
            birthdayInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthdayInput.widthAnchor.constraint(equalToConstant: 200),
            birthdayInput.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            contactInput.topAnchor.constraint(equalTo: birthdayInput.bottomAnchor, constant: 20),
            contactInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contactInput.widthAnchor.constraint(equalToConstant: 200),
            contactInput.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: contactInput.bottomAnchor, constant: 20),
            aboutMeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutMeInput.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 20),
            aboutMeInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutMeInput.widthAnchor.constraint(equalToConstant: 300),
            aboutMeInput.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 45),
            saveButton.widthAnchor.constraint(equalToConstant: 90),
            saveButton.topAnchor.constraint(equalTo: aboutMeInput.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func save() {
        if ((nameInput.text == "" || nameInput.text == nil) && parentController!.name.text == ""){
            showAlert()
        }
        else{
        if (nameInput.text != "") {
            parentController!.name.text = nameInput.text!
            }
        if (birthdayInput.text != "") {
                parentController!.birthday.text = "My Birthday: " + birthdayInput.text!
            }
        if (contactInput.text != ""){
                parentController!.contact.text = "Find me at: " + contactInput.text!
            }
            if (aboutMeInput.text != ""){
                parentController!.aboutMe.text = aboutMeInput.text
            }
        navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Name Required!", message: "To continue, please enter a name for your profile.", preferredStyle: .alert)
        alert.addTextField { textField in textField.placeholder = "Enter name: "}
        alert.addAction(UIAlertAction(title: "Update", style: .default) { _ in
            guard let newName = alert.textFields?[0].text, !newName.isEmpty else{
                self.showAlert()
                return
            }
            self.nameInput.text = newName
            self.save()
        })
        present(alert, animated: true, completion: nil)
    }
    
}
