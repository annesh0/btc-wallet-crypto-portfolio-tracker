//
//  EditorController.swift
//  Navigation
//
//  Created by Dylan McCreesh on 6/5/22.
//

import UIKit

class EditorController: UIViewController {
    
    var confirm = UIButton()
    var pic1 = UIButton()
    var pic2 = UIButton()
    weak var parentController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit Profile Picture"
        title = "Choose Your New Profile Picture"
        view.backgroundColor = .white
        
        confirm.setTitle("  Cancel  ", for: .normal)
        confirm.setTitleColor(.white, for: .normal)
        confirm.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 255/255, alpha: 1.0)
        confirm.translatesAutoresizingMaskIntoConstraints = false
        confirm.addTarget(self, action: #selector(save), for: .allTouchEvents)
        confirm.layer.cornerRadius = 15
        view.addSubview(confirm)
        
        pic1.setImage(UIImage(named:"shopping cart"), for: .normal)
        pic1.layer.borderWidth = 1
        pic1.layer.borderColor = UIColor.systemGray.cgColor
        pic1.layer.cornerRadius = 0
        pic1.translatesAutoresizingMaskIntoConstraints = false
        pic1.addTarget(self, action: #selector(pressPic1), for: .touchUpInside)
        view.addSubview(pic1)
        
        pic2.setImage(UIImage(named:"shopping cart 2"), for: .normal)
        pic2.layer.borderWidth = 1
        pic2.layer.borderColor = UIColor.systemGray.cgColor
        pic2.layer.cornerRadius = 0
        pic2.translatesAutoresizingMaskIntoConstraints = false
        pic2.addTarget(self, action: #selector(pressPic2), for: .touchUpInside)
        view.addSubview(pic2)
        
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            confirm.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            confirm.heightAnchor.constraint(equalToConstant: 45),
            confirm.widthAnchor.constraint(equalToConstant: 90),
            confirm.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            pic1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pic1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pic1.heightAnchor.constraint(equalToConstant: 150),
            pic1.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            pic2.topAnchor.constraint(equalTo: pic1.bottomAnchor, constant: 20),
            pic2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pic2.heightAnchor.constraint(equalToConstant: 150),
            pic2.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func save() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pressPic1() {
        pic1.layer.borderColor = UIColor(red: 155/255, green: 155/255, blue: 255/255, alpha: 1.0).cgColor
        pic2.layer.borderColor = UIColor.systemGray.cgColor
        confirm.setTitle("  Save  ", for: .normal)
        parentController?.pfp.setImage(UIImage(named:"shopping cart"), for: .normal)
    }
    
    @objc func pressPic2() {
        pic2.layer.borderColor = UIColor(red: 155/255, green: 155/255, blue: 255/255, alpha: 1.0).cgColor
        pic1.layer.borderColor = UIColor.systemGray.cgColor
        confirm.setTitle("  Save  ", for: .normal)
        parentController?.pfp.setImage(UIImage(named:"shopping cart 2"), for: .normal)
    }
}
