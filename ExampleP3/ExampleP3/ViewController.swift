//
//  ViewController.swift
//  ExampleP3
//
//  Created by Dylan McCreesh on 6/3/22.
//

import UIKit

class ViewController: UIViewController {

    var background = UITextView()
    var name = UILabel()
    var aboutMe = UITextView()
    var aboutMeLabel = UILabel()
    var birthday = UILabel()
    var contact = UILabel()
    var infoEditButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Update Profile Info ", for: .normal)
        button.addTarget(self, action: #selector(editProfileInfo), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 255/255, alpha: 1.0)
        button.layer.cornerRadius = 15
        return button
    }()
    
    var pfp: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shopping cart"), for: .normal)
        button.addTarget(self, action: #selector(editPFP), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 155/255, green: 155/255, blue: 255/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Profile"
        // Do any additional setup after loading the view.
        
        name.text = ""
        name.textColor = .black
        name.font = .systemFont(ofSize: 20, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        
        background.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 245/255, alpha: 1.0)
        background.isEditable = false
        background.isSelectable = false
        background.isScrollEnabled = false
        background.layer.cornerRadius = 20
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        
        birthday.text = "My Birthday:"
        birthday.textColor = .white
        birthday.font = .systemFont(ofSize: 18, weight: .regular)
        birthday.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(birthday)
        
        contact.text = "Find me at:"
        contact.textColor = .white
        contact.font = .systemFont(ofSize: 18, weight: .regular)
        contact.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contact)
        
        aboutMeLabel.text = "About Me:"
        aboutMeLabel.textColor = .black
        aboutMeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutMeLabel)
        
        aboutMe.textColor = .white
        aboutMe.font = .systemFont(ofSize: 15)
        aboutMe.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 255/255, alpha: 1.0)
        aboutMe.isEditable = false
        aboutMe.isScrollEnabled = true
        aboutMe.layer.cornerRadius = 20
        aboutMe.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutMe)
        
        infoEditButton.translatesAutoresizingMaskIntoConstraints = false
        pfp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoEditButton)
        view.addSubview(pfp)
        
        setupConstraints()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            pfp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            pfp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pfp.widthAnchor.constraint(equalToConstant: 250),
            pfp.heightAnchor.constraint(equalToConstant: 250)])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: pfp.bottomAnchor, constant: 5),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([
            birthday.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25),
            birthday.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40)])
        
        NSLayoutConstraint.activate([
            contact.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 25),
            contact.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40)])
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15),
            background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            background.widthAnchor.constraint(equalToConstant: 340),
            background.heightAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: background.bottomAnchor, constant: 15),
            aboutMeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aboutMe.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 15),
            aboutMe.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            aboutMe.widthAnchor.constraint(equalToConstant: 340),
            aboutMe.heightAnchor.constraint(equalToConstant: 150)])
        
        NSLayoutConstraint.activate([
            infoEditButton.topAnchor.constraint(equalTo: aboutMe.bottomAnchor, constant: 30),
            infoEditButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    @objc func editProfileInfo() {
        let infoEditor = MainController()
        infoEditor.parentController = self
        print("I've Been Pressed")
        navigationController?.pushViewController(infoEditor, animated: true)
    }
    
    @objc func editPFP() {
        let presenter = EditorController()
        presenter.parentController = self
        present(presenter, animated: true, completion: nil)
    }
}

