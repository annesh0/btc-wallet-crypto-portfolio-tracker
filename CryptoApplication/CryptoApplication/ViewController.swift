//
//  ViewController.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/6/22.
//

import UIKit

class ViewController: UIViewController {

    var tableView = UITableView()

    let reuseIdentifier = "coinCellReuse"
    let cellHeight: CGFloat = 50

    var allCoins: [Coin] = []
    var myCoins: [Coin] = []
    var padding = UITextView()
    var netWorthLabel = UILabel()
    var netWorth = 0.0
    var netChangeLabel = UILabel()
    var assetsLabel = UILabel()
    var editAssestsButton = UIButton()
    var addAssestsButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Portfolio"
        padding.isEditable = false
        padding.isSelectable = false
        padding.isScrollEnabled = false
        padding.backgroundColor = .lightGray
        padding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(padding)
        netWorthLabel.text = "$\(self.getCurrencyForm(amount: self.netWorth))"
        netWorthLabel.font = .systemFont(ofSize: 35, weight: .bold)
        netWorthLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netWorthLabel)
        netChangeLabel.text = "+XX.X%"
        netChangeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        netChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netChangeLabel)
        assetsLabel.text = "Assets"
        assetsLabel.font = .systemFont(ofSize: 30, weight: .bold)
        assetsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(assetsLabel)
        editAssestsButton.setTitle("   Edit   ", for: .normal)
        editAssestsButton.addTarget(self, action: #selector(pushEditScreen), for: .touchUpInside)
        editAssestsButton.setTitleColor(.white, for: .normal)
        editAssestsButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        editAssestsButton.layer.cornerRadius = 10
        editAssestsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editAssestsButton)
        addAssestsButton.setTitle("  Add  ", for: .normal)
        addAssestsButton.addTarget(self, action: #selector(presentAddScreen), for: .touchUpInside)
        addAssestsButton.setTitleColor(.white, for: .normal)
        addAssestsButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        addAssestsButton.layer.cornerRadius = 15
        addAssestsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAssestsButton)
        view.backgroundColor = .white
        
        let bitcoin = Coin(name: "Bitcoin", symbol: "BTC")
        let dogecoin = Coin(name: "Dogecoin", symbol: "DOGE")
        allCoins = [bitcoin, dogecoin]
        // Initialize tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)

        setupConstraints()
    }

    func setupConstraints() {
//         Setup the constraints for our views
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: assetsLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150)
        ])
        
        NSLayoutConstraint.activate([
            padding.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            padding.topAnchor.constraint(equalTo: view.topAnchor),
            padding.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            padding.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            netWorthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            netWorthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            netChangeLabel.topAnchor.constraint(equalTo: netWorthLabel.bottomAnchor, constant: 15),
            netChangeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            assetsLabel.topAnchor.constraint(equalTo: padding.bottomAnchor, constant: 15),
            assetsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            editAssestsButton.centerYAnchor.constraint(equalTo: assetsLabel.centerYAnchor),
            editAssestsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            editAssestsButton.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            addAssestsButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 15),
            addAssestsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func pushEditScreen(){
        let coinEditor = EditCoinController()
        coinEditor.parentController = self
        navigationController?.pushViewController(coinEditor, animated: true)
    }
    
    @objc func presentAddScreen(){
        let presenter = AddCoinController()
        presenter.parentController = self
        present(UINavigationController(rootViewController: presenter), animated: true, completion: nil)
    }
    
    func updateMyCoins(){
        tableView.beginUpdates()
        if myCoins.count > 0 {
            for i in 0...myCoins.count-1{
                    tableView.deleteRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
            }
        }
        myCoins = []
        for coin in allCoins {
            if coin.isChosen{
                myCoins.append(coin)
            }
        }
        if myCoins.count > 0 {
            for i in 0...myCoins.count-1{
                    tableView.insertRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
            }
        }
        tableView.endUpdates()
    }
    
    func getCurrencyForm(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.currencySymbol = ""
        formatter.numberStyle = .currency
        return formatter.string(from: amount as NSNumber)!
    }
    
    func updateNetWorth(){
        netWorth = 0.0
        for coin in myCoins {
            netWorth = netWorth + coin.amountUSD
        }
        netWorthLabel.text = "$\(self.getCurrencyForm(amount: self.netWorth))"
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCoins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CoinTableViewCell {
                let coin = myCoins[indexPath.row]
                cell.configure(coin: coin)
                cell.selectionStyle = .none
                return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinView = SingleCoinViewController()
        let coin = myCoins[indexPath.row]
        coinView.parentController = self
        coinView.parentCoin = coin
        navigationController?.pushViewController(coinView, animated: true)
    }
}

