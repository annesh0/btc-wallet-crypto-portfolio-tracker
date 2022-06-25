//
//  ViewController.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/6/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var tableView = UITableView()
    
    let refreshControl = UIRefreshControl()

    let reuseIdentifier = "coinCellReuse"
    let cellHeight: CGFloat = 50

    var allCoins: [Coin] = []
    var myCoins: [Coin] = []
    
    var persistenceManager = PersistenceManager.shared
    var savedCoins = codableCoins()
    
    var padding = UITextView()
    var netWorthLabel = UILabel()
    var netWorth = 0.0
    var netChangeLabel = UILabel()
    var netChange = 0.0
    var assetsLabel = UILabel()
    var editAssestsButton = UIButton()
    var addAssestsButton = UIButton()
    
    var walletButton = UIButton()
    var portfolioButton = UIButton()
    var newsButton = UIButton()
    var borderBuffer = UITextView()
    
    var allData: AllData?
    
    var loadedNewsScreen = NewsViewController()
    var loadedWalletScreen = WalletViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Portfolio"
        view.backgroundColor = .white
        
        loadedNewsScreen.loadedPortfolioScreen = self
        loadedWalletScreen.loadedPortfolioScreen = self

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
        netChangeLabel.text = getRoundedPercentage(amount: netChange)
        netChangeLabel.font = .systemFont(ofSize: 20, weight: .bold)
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
        addAssestsButton.setBackgroundImage(UIImage(named: "plus_button"), for: .normal)
        addAssestsButton.addTarget(self, action: #selector(presentAddScreen), for: .touchUpInside)
        addAssestsButton.layer.cornerRadius = 1000
        addAssestsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAssestsButton)
        walletButton.backgroundColor = .white
        walletButton.layer.borderColor = UIColor.lightGray.cgColor
        walletButton.layer.borderWidth = 0.5
        walletButton.layer.cornerRadius = 0
        walletButton.addTarget(self, action: #selector(walletButtonPress), for: .touchUpInside)
        walletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletButton)
        portfolioButton.backgroundColor = .lightGray
        portfolioButton.layer.borderColor = UIColor.lightGray.cgColor
        portfolioButton.layer.borderWidth = 0.5
        portfolioButton.layer.cornerRadius = 0
        portfolioButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(portfolioButton)
        newsButton.backgroundColor = .white
        newsButton.layer.borderColor = UIColor.lightGray.cgColor
        newsButton.layer.borderWidth = 0.5
        newsButton.layer.cornerRadius = 0
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        newsButton.addTarget(self, action: #selector(newsButtonPress), for: .touchUpInside)
        view.addSubview(newsButton)
        borderBuffer.isEditable = false
        borderBuffer.isSelectable = false
        borderBuffer.isScrollEnabled = false
        borderBuffer.backgroundColor = .lightGray
        borderBuffer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(borderBuffer)
        
        let bitcoin = Coin(name: "Bitcoin", symbol: "BTC")
        let dogecoin = Coin(name: "Dogecoin", symbol: "DOGE")
        let ethereum = Coin(name: "Ethereum", symbol: "ETH")
        let litecoin = Coin(name:"Litecoin",symbol: "LTC")
        let cardano = Coin(name:"Cardano",symbol: "ADA")
        let tether = Coin(name:"USDTether",symbol: "USDT")
        let solana = Coin(name:"Solana",symbol: "SOL")
        let binance = Coin(name:"Binance Coin",symbol: "BNB")
        let usdCoin = Coin(name:"USDCoin",symbol: "USDC")
        let algorand = Coin(name:"Algorand",symbol: "ALGO")
        let polkadot = Coin(name:"Polkadot",symbol: "DOT")
        let bitcoinCash = Coin(name:"Bitcoin Cash",symbol: "BCH")
        let monero = Coin(name:"Monero",symbol: "XMR")
        let uniswap = Coin(name:"Uniswap",symbol: "UNI")
        let shibainu = Coin(name:"Shiba Inu",symbol: "SHIB")
        allCoins = [bitcoin, dogecoin, ethereum, litecoin, cardano, tether, solana, binance, usdCoin, algorand, polkadot, bitcoinCash, monero, uniswap, shibainu]
                
        if let loaded = persistenceManager.load(){
            savedCoins = loaded
            var i = 0
            for coin in allCoins {
                coin.savableCoin = savedCoins.items[i]
                i = i + 1
                coin.getSavedData()
                coin.amountUSD = coin.amountCoin * coin.conversionRate
            }
        }
        else{
            saveCoinCells()
        }
        // Initialize tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
                
        getCoinData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateMyCoins()
            self.updateNetWorthAndNetChange()
        }
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
            addAssestsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAssestsButton.heightAnchor.constraint(equalToConstant: 50),
            addAssestsButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            walletButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            walletButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            walletButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            walletButton.trailingAnchor.constraint(equalTo: portfolioButton.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            portfolioButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            portfolioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            portfolioButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            portfolioButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0/3.0)
        ])
        
        NSLayoutConstraint.activate([
            newsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            newsButton.leadingAnchor.constraint(equalTo: portfolioButton.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            borderBuffer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderBuffer.bottomAnchor.constraint(equalTo: portfolioButton.topAnchor),
            borderBuffer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderBuffer.heightAnchor.constraint(equalToConstant: 0.5)
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
    
    @objc func newsButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedNewsScreen)
    }
    
    @objc func walletButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedWalletScreen)
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
    
    func getRoundedPercentage(amount: Double) -> String{
        return "\(round(amount * 10)/10.0)%"
    }
    
    func updateNetWorthAndNetChange(){
        saveCoinCells()
        netWorth = 0.0
        var oldWorth = 0.0
        for coin in myCoins {
            coin.amountUSD = coin.conversionRate * coin.amountCoin
            coin.percentChnage = ((coin.conversionRate - coin.previousConversionRate)/coin.previousConversionRate) * 100.0
            netWorth = netWorth + coin.amountUSD
            oldWorth = oldWorth + coin.amountUSD/(1 + coin.percentChnage/100)
        }
        netWorthLabel.text = "$\(self.getCurrencyForm(amount: self.netWorth))"
        netChange = ((netWorth/oldWorth) - 1) * 100
        netChangeLabel.text = self.getRoundedPercentage(amount: netChange)
        netChangeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        if (netChange > 0){
            netChangeLabel.textColor = UIColor(red: 142/255, green: 236/255, blue: 127/255, alpha: 1)
        }
        if (netChange < 0){
            netChangeLabel.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1)
        }
        tableView.reloadData()
    }
    
    func saveCoinCells(){
        savedCoins.items = []
        for coin in allCoins {
            coin.updateSavableCoin()
            savedCoins.items.append(coin.savableCoin)
        }
        persistenceManager.save(coins: savedCoins)
    }
    
    @objc func refresh(){
        getCoinData()
        updateNetWorthAndNetChange()
        refreshControl.endRefreshing()
    }
    
    func getCoinData() {
        NetworkManager.getAllCoinValues { (data,error) in
            //print(data!)
            var a: [String:Any] = [:]
            a = data as! [String : Any]
            //print(a["asset_id_base"]!)
            var ratesArr: [[String:Any]] = []
            ratesArr = a["rates"] as! [[String : Any]]
            //print(ratesArr[0]["asset_id_quote"]!)
            self.assignValues(ratesInfo: ratesArr)
            //print(self.allCoins[0].conversionRate)
            //@todo: Call reload changes here
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        NetworkManager.getOldCoinValues { (data,error) in
            //print(data!)
            var a: [String:Any] = [:]
            a = data as! [String : Any]
            //print(a["asset_id_base"]!)
            var ratesArr: [[String:Any]] = []
            ratesArr = a["rates"] as! [[String : Any]]
            //print(ratesArr[0]["asset_id_quote"]!)
            self.assignOldValues(ratesInfo: ratesArr)
            //print(self.allCoins[0].conversionRate)
            //@todo: Call reload changes here
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func assignValues(ratesInfo: [[String:Any]]) {
        for rateInfo in ratesInfo {
            switch rateInfo["asset_id_quote"] as! String {
            case self.allCoins[0].symbol:
                self.allCoins[0].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[1].symbol:
                self.allCoins[1].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[2].symbol:
                self.allCoins[2].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[3].symbol:
                self.allCoins[3].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[4].symbol:
                self.allCoins[4].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[5].symbol:
                self.allCoins[5].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[6].symbol:
                self.allCoins[6].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[7].symbol:
                self.allCoins[7].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[8].symbol:
                self.allCoins[8].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[9].symbol:
                self.allCoins[9].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[10].symbol:
                self.allCoins[10].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[11].symbol:
                self.allCoins[11].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[12].symbol:
                self.allCoins[12].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[13].symbol:
                self.allCoins[13].conversionRate = rateInfo["rate"] as! Double
            case self.allCoins[14].symbol:
                self.allCoins[14].conversionRate = rateInfo["rate"] as! Double
            default:
                continue
            }
        }
    }
        
    func assignOldValues(ratesInfo: [[String:Any]]) {
        for rateInfo in ratesInfo {
            switch rateInfo["asset_id_quote"] as! String {
            case self.allCoins[0].symbol:
                self.allCoins[0].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[1].symbol:
                self.allCoins[1].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[2].symbol:
                self.allCoins[2].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[3].symbol:
                self.allCoins[3].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[4].symbol:
                self.allCoins[4].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[5].symbol:
                self.allCoins[5].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[6].symbol:
                self.allCoins[6].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[7].symbol:
                self.allCoins[7].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[8].symbol:
                self.allCoins[8].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[9].symbol:
                self.allCoins[9].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[10].symbol:
                self.allCoins[10].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[11].symbol:
                self.allCoins[11].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[12].symbol:
                self.allCoins[12].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[13].symbol:
                self.allCoins[13].previousConversionRate = rateInfo["rate"] as! Double
            case self.allCoins[14].symbol:
                self.allCoins[14].previousConversionRate = rateInfo["rate"] as! Double
            default:
                continue
            }
        }
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
