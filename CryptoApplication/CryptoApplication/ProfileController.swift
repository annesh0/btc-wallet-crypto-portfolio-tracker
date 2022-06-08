/*
//
//  ProfileController.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 6/5/22.
//

import UIKit

class ProfileController: UIViewController {
    
    var saveButton = UIButton()
    var firstPic = UIButton()
    var secondPic = UIButton()
    var parentController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit Profile Picture"
        //title = "Edit Profile Picture"
        view.backgroundColor = .white
        title = "Edit Profile Picture"
        self.parent?.title = "Title Here"
        
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(save), for: .allTouchEvents)
        view.addSubview(saveButton)
        
        firstPic.setImage(UIImage(named:"anon"), for: .normal)
        firstPic.layer.borderWidth = 1
        firstPic.layer.borderColor = UIColor.systemGray.cgColor
        firstPic.layer.cornerRadius = 10
        firstPic.translatesAutoresizingMaskIntoConstraints = false
        firstPic.addTarget(self, action: #selector(onFirstPress), for: .touchUpInside)
        view.addSubview(firstPic)
        
        secondPic.setImage(UIImage(named:"anon2"), for: .normal)
        secondPic.layer.borderWidth = 1
        secondPic.layer.borderColor = UIColor.systemGray.cgColor
        secondPic.layer.cornerRadius = 10
        secondPic.translatesAutoresizingMaskIntoConstraints = false
        secondPic.addTarget(self, action: #selector(onSecondPress), for: .touchUpInside)
        view.addSubview(secondPic)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            saveButton.heightAnchor.constraint(equalToConstant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            firstPic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            firstPic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstPic.heightAnchor.constraint(equalToConstant: 100),
            firstPic.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            secondPic.topAnchor.constraint(equalTo: firstPic.bottomAnchor, constant: 15),
            secondPic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondPic.heightAnchor.constraint(equalToConstant: 100),
            secondPic.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func save() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onFirstPress() {
        firstPic.layer.borderColor = UIColor.systemBlue.cgColor
        firstPic.layer.borderWidth = 2
        parentController?.profilePic.setImage(UIImage(named:"anon"), for: .normal)
        //save()
    }
    
    @objc func onSecondPress() {
        secondPic.layer.borderColor = UIColor.systemBlue.cgColor
        secondPic.layer.borderWidth = 2
        parentController?.profilePic.setImage(UIImage(named:"anon2"), for: .normal)
        //save()
    }
}

*/
