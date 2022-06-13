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
    var symbolLabel = UILabel()
    var inputField = UITextField()
    var saveButton = UIButton()
    weak var parentCoinCell: Coin?
    weak var ParentController: EditCoinController?
    
    override func viewDidLoad() {
        title = "Edit Asset: " + parentCoinCell!.name
        view.backgroundColor = .white
        instructionsLabel.text = "Please enter the amount of \(parentCoinCell!.name) you own:"
        instructionsLabel.font = .systemFont(ofSize: 15, weight: .bold)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)
        inputField.placeholder = " Enter amount: "
        inputField.textColor = .black
        inputField.font = .systemFont(ofSize: 15, weight: .regular)
        inputField.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.00)
        inputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputField)
        symbolLabel.text = parentCoinCell!.symbol
        symbolLabel.font = .systemFont(ofSize: 15, weight: .bold)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(symbolLabel)
        saveButton.setTitle("  Save  ", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        saveButton.layer.cornerRadius = 15
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            inputField.leadingAnchor.constraint(equalTo: instructionsLabel.leadingAnchor),
            inputField.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            inputField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: inputField.trailingAnchor, constant: 5),
            symbolLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            symbolLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func save() {
        if (inputField.text == nil)
        {
            showAlert()
        }
        else {
            
            parentCoinCell!.amountCoin = NSDecimalNumber(string: inputField.text!)
            parentCoinCell!.amountUSD = parentCoinCell!.conversionRate.multiplying(by: parentCoinCell!.amountCoin)
            ParentController!.tableView.reloadData()
            ParentController!.parentController!.tableView.reloadData()
            ParentController!.parentController!.updateNetWorth()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlert() {
            let alert = UIAlertController(title: "Number Required!", message: "To continue, you must enter a number.", preferredStyle: .alert)
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

}
