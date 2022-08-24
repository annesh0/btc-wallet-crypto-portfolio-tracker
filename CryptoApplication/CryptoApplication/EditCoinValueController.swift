//
//  AddCoinController.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//

import UIKit
import Foundation

class EditCoinValueController: UIViewController {
    
    var instructionsLabel = UILabel()
    var inputField = UITextField()
    var logoImageView = UIImageView()
    var saveButton = UIButton()
    var cancelButton = UIButton()
    let gradient = CAGradientLayer()
    
    var fromSignleScreen = false
    weak var parentSingleCoinScreen: SingleCoinViewController?
    
    var lastKnownValue = 0.0
    
    weak var parentCoinCell: Coin?
    weak var ParentController: EditCoinController?
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        title = "Edit Asset: " + parentCoinCell!.name
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        instructionsLabel.text = "Edit \(parentCoinCell!.name)"
        instructionsLabel.font = .systemFont(ofSize: 35, weight: .bold)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)
        inputField.attributedPlaceholder = NSAttributedString(string: "Enter amount \(parentCoinCell!.symbol):", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        inputField.textColor = .black
        inputField.font = .systemFont(ofSize: 15, weight: .bold)
        inputField.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.00)
        inputField.textAlignment = .center
        inputField.layer.cornerRadius = 20
        inputField.keyboardType = .decimalPad
        inputField.addTarget(self, action: #selector(numberOnly), for: .editingChanged)
        inputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputField)
        saveButton.setTitle("  Confirm  ", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        saveButton.setTitleColor(.darkGray, for: .normal)
        saveButton.backgroundColor = .clear
        saveButton.layer.cornerRadius = 15
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        cancelButton.setTitle("  Cancel  ", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.layer.cornerRadius = 15
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        logoImageView.image = parentCoinCell!.logoImage
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        let gradientColor = parentCoinCell!.mainColor.cgColor
        gradient.frame = CGRect(x:0, y: view.frame.height * 0.5, width: view.frame.width, height: view.frame.height * 0.5)
        gradient.colors = [UIColor.white.cgColor, gradientColor.copy(alpha: 0.5)!]
        view.layer.insertSublayer(gradient, at: 0)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            instructionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionsLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            inputField.centerXAnchor.constraint(equalTo: instructionsLabel.centerXAnchor),
            inputField.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 15),
            inputField.heightAnchor.constraint(equalToConstant: 60),
            inputField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/20.0),
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/15.0)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width/20.0)),
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/15.0)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 15),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc func save() {
        
        if fromSignleScreen{
            if let value = Double(inputField.text!){
                if value < 0 {
                    showAlert()
                }
                else {
                    parentCoinCell!.amountCoin = value
                    parentCoinCell!.amountUSD = parentCoinCell!.conversionRate * parentCoinCell!.amountCoin
                    parentSingleCoinScreen!.parentController!.tableView.reloadData()
                    parentSingleCoinScreen!.parentController!.updateNetWorthAndNetChange()
                    parentSingleCoinScreen!.updateData()
                    self.navigationController?.isNavigationBarHidden = false
                    navigationController?.popViewController(animated: true)
                }
            }
            else{
                if inputField.text == ""{
                    cancel()
                }
                else{
                    showAlert()
                }
            }
        }
        
        else{
            if let value = Double(inputField.text!){
                if value < 0 {
                    showAlert()
                }
                else {
                    parentCoinCell!.amountCoin = value
                    parentCoinCell!.amountUSD = parentCoinCell!.conversionRate * parentCoinCell!.amountCoin
                    ParentController!.tableView.reloadData()
                    ParentController!.parentController!.tableView.reloadData()
                    ParentController!.parentController!.updateNetWorthAndNetChange()
                    self.navigationController?.isNavigationBarHidden = false
                    navigationController?.popViewController(animated: true)
                }
            }
            else{
                if inputField.text == ""{
                    cancel()
                }
                else{
                    showAlert()
                }            }
        }
    }
    
    @objc func cancel() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
            let alert = UIAlertController(title: "Valid Number Required!", message: "To continue, you must enter a valid number.", preferredStyle: .alert)
            alert.addTextField { textField in textField.placeholder = "Enter amount: "}
            alert.addAction(UIAlertAction(title: "Update", style: .default) { _ in
                guard let newAmount = alert.textFields?[0].text, !newAmount.isEmpty else{
                    self.showAlert()
                    return
                }
                self.inputField.text = newAmount
                self.save()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) { _ in return})
            present(alert, animated: true, completion: nil)
    }

    @objc func numberOnly(){
        if let text = inputField.text {
            if let amount = Double(text){
                lastKnownValue = amount
            }
            else if inputField.text != "" {
                inputField.text = "\(lastKnownValue)"
            }
        }
    }
}
