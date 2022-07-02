//
//  AddCoinController.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//

import UIKit

class AddCoinController: UIViewController {
    
    var tableView = UITableView()
    var assetsLabel = UILabel()
    weak var parentController: ViewController?
    
    override func viewDidLoad() {
        //title = "Add/Remove Assets"
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(AddCoinTableViewCell.self, forCellReuseIdentifier: parentController!.reuseIdentifier)
        view.addSubview(tableView)
        assetsLabel.text = "Add/Remove Assets"
        assetsLabel.font = .systemFont(ofSize: 28, weight: .bold)
        assetsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(assetsLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: assetsLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            assetsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            assetsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func save() {
        navigationController?.popViewController(animated: true)
    }
    
    func toggleCoin(coin: Coin){
        coin.isChosen = !coin.isChosen
        coin.amountCoin = 0.0
        coin.amountUSD = 0.0
        self.parentController!.updateMyCoins()
        self.tableView.reloadData()
        self.parentController!.tableView.reloadData()
        self.parentController!.updateNetWorthAndNetChange()
    }
    
    func showAlert(coin: Coin) {
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to remove \(coin.name) from your assets? Doing so will erase our saved data on the amount of this asset you own.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
                self.toggleCoin(coin: coin)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) { _ in return})
            present(alert, animated: true, completion: nil)
    }
    
}

extension AddCoinController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentController!.allCoins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: parentController!.reuseIdentifier, for: indexPath) as? AddCoinTableViewCell {
            let coin = parentController!.allCoins[indexPath.row]
                cell.configure(coin: coin)
                cell.selectionStyle = .none
                return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension AddCoinController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = parentController!.allCoins[indexPath.row]
        if coin.isChosen{
            self.showAlert(coin: coin)
        }
        else{
            self.toggleCoin(coin: coin)
        }
    }
}
