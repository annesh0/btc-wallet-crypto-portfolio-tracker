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
        title = "Edit Assets"
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AddCoinTableViewCell.self, forCellReuseIdentifier: parentController!.reuseIdentifier)
        view.addSubview(tableView)
        assetsLabel.text = "Assets"
        assetsLabel.font = .systemFont(ofSize: 30, weight: .bold)
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
            assetsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            assetsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    @objc func save() {
        navigationController?.popViewController(animated: true)
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
        return 85
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = parentController!.allCoins[indexPath.row]
        coin.isChosen = !coin.isChosen
        parentController!.updateMyCoins()
        tableView.reloadData()
        parentController!.tableView.reloadData()
    }
}
