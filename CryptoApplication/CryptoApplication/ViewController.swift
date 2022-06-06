//
//  ViewController.swift
//  CryptoApplication
//
//  Created by Annesh Ghosh Dastidar on 5/23/22.
//

import UIKit

class ViewController: UIViewController {

    var profilePic = UIButton()
    var nameLabel = UILabel()
    var aboutHeaderLabel = UILabel()
    var aboutLabel = UILabel()
    var editProfileButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "My Profile"
        
        profilePic.setImage(UIImage(named:"anon"), for: .normal)
        profilePic.layer.borderWidth = 1
        profilePic.layer.borderColor = UIColor.systemGray.cgColor
        profilePic.layer.cornerRadius = 10
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        profilePic.addTarget(self, action: #selector(onProfilePicPress), for: .touchUpInside)
        view.addSubview(profilePic)
        
        editProfileButton.setTitle("Button", for: .normal)
        editProfileButton.setTitleColor(.systemBlue, for: .normal)
        editProfileButton.addTarget(self, action: #selector(onEditProfileButtonPress), for: .touchUpInside)
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = UIColor.systemBlue.cgColor
        editProfileButton.layer.cornerRadius = 10
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editProfileButton)
        
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        aboutLabel.textColor = .black
        aboutLabel.font = .systemFont(ofSize: 20)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutLabel)
        
        
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15 ),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePic.widthAnchor.constraint(equalToConstant: 100),
            profilePic.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
        NSLayoutConstraint.activate([
            editProfileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 15),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            aboutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func onEditProfileButtonPress() {
        let editor = EditorController()
        editor.parentController = self
        navigationController?.pushViewController(editor, animated: true)
    }
    
    @objc func onProfilePicPress() {
        let profile = ProfileController()
        profile.parentController = self
        present(profile, animated: true, completion: nil)
    }


}

