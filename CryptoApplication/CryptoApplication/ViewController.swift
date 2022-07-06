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
    
    let gradient1 = CAGradientLayer()
    let gradient2 = CAGradientLayer()
    
    var netWorthLabel = UILabel()
    var netWorth = 0.0
    var netChangeLabel = UILabel()
    var netChangeImage = UIImageView()
    var netChange = 0.0
    var assetsLabel = UILabel()
    var editAssestsButton = UIButton()
    var addAssestsButton = UIButton()
    
    var walletButton = UIButton()
    var portfolioButton = UIButton()
    var newsButton = UIButton()
    
    var allData: AllData?
    
    var firstTimeLoading = true
        
    var loadedNewsScreen = NewsViewController()
    var loadedWalletScreen = WalletViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadedNewsScreen.loadedPortfolioScreen = self
        //loadedNewsScreen.getArticleData()
        loadedWalletScreen.loadedPortfolioScreen = self
        
        let myBackBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        myBackBarButtonItem.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = myBackBarButtonItem
        
        self.navigationController?.setNeedsUpdateOfHomeIndicatorAutoHidden()
        
        let blueColor = UIColor(red: 169/255, green: 196/255, blue: 238/255, alpha: 1)
        let midPointColor = UIColor(red: 169/255, green: 196/255, blue: 238/255, alpha: 0.99)
        gradient1.frame = CGRect(x:0, y:0, width: view.frame.width, height: 50)
        gradient1.colors = [blueColor.cgColor, midPointColor.cgColor]
        view.layer.insertSublayer(gradient1, at: 0)
        gradient2.frame = CGRect(x:0, y:50, width: view.frame.width, height: 150)
        gradient2.colors = [midPointColor.cgColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient2, at: 0)

        netWorthLabel.text = "$\(self.getCurrencyForm(amount: self.netWorth))"
        netWorthLabel.font = .systemFont(ofSize: 35, weight: .bold)
        netWorthLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netWorthLabel)
        netChangeLabel.text = getRoundedPercentage(amount: netChange)
        netChangeLabel.font = .systemFont(ofSize: 20, weight: .bold)
        netChangeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        netChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netChangeLabel)
        netChangeImage.contentMode = .scaleAspectFit
        netChangeImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netChangeImage)
        assetsLabel.text = "Assets"
        assetsLabel.font = .systemFont(ofSize: 30, weight: .bold)
        assetsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(assetsLabel)
        editAssestsButton.setTitle("   Edit   ", for: .normal)
        editAssestsButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        editAssestsButton.addTarget(self, action: #selector(pushEditScreen), for: .touchUpInside)
        editAssestsButton.setTitleColor(.white, for: .normal)
        editAssestsButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        editAssestsButton.layer.cornerRadius = 13
        editAssestsButton.layer.shadowColor = UIColor.black.cgColor
        editAssestsButton.layer.masksToBounds = false
        editAssestsButton.layer.shadowOpacity = 0.5
        editAssestsButton.layer.shadowRadius = 3
        editAssestsButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        editAssestsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editAssestsButton)
        addAssestsButton.setBackgroundImage(UIImage(named: "plus_button"), for: .normal)
        addAssestsButton.addTarget(self, action: #selector(presentAddScreen), for: .touchUpInside)
        addAssestsButton.layer.cornerRadius = 1000
        addAssestsButton.layer.shadowColor = UIColor.black.cgColor
        addAssestsButton.layer.masksToBounds = false
        addAssestsButton.layer.shadowOpacity = 0.5
        addAssestsButton.layer.shadowRadius = 3
        addAssestsButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addAssestsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addAssestsButton)
        
        walletButton.setBackgroundImage(UIImage(named: "wallet1"), for: .normal)
        walletButton.backgroundColor = .white
        walletButton.addTarget(self, action: #selector(walletButtonPress), for: .touchUpInside)
        walletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletButton)
        
        portfolioButton.setBackgroundImage(UIImage(named: "portfolio2"), for: .normal)
        portfolioButton.backgroundColor = .white
        portfolioButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(portfolioButton)
        
        newsButton.setBackgroundImage(UIImage(named:"news1"), for: .normal)
        newsButton.backgroundColor = .white
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        newsButton.addTarget(self, action: #selector(newsButtonPress), for: .touchUpInside)
        view.addSubview(newsButton)
        
        let bitcoin = Coin(name: "Bitcoin", symbol: "BTC", internalAssetID: 0)
        bitcoin.mainColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1)
        let dogecoin = Coin(name: "Dogecoin", symbol: "DOGE", internalAssetID: 1)
        dogecoin.mainColor = UIColor(red: 194/255, green: 166/255, blue: 51/255, alpha: 1)
        let ethereum = Coin(name: "Ethereum", symbol: "ETH", internalAssetID: 2)
        ethereum.mainColor = UIColor(red: 60/255, green: 60/255, blue: 61/255, alpha: 1)
        let litecoin = Coin(name:"Litecoin",symbol: "LTC", internalAssetID: 3)
        litecoin.mainColor = UIColor(red: 52/255, green: 93/255, blue: 157/255, alpha: 1)
        let cardano = Coin(name:"Cardano",symbol: "ADA", internalAssetID: 4)
        cardano.mainColor = UIColor(red: 0/255, green: 51/255, blue: 173/255, alpha: 1)
        let tether = Coin(name:"USDTether",symbol: "USDT", internalAssetID: 5)
        tether.mainColor = UIColor(red: 38/255, green: 161/255, blue: 123/255, alpha: 1)
        let solana = Coin(name:"Solana",symbol: "SOL", internalAssetID: 6)
//        solana.mainColor = UIColor(red: 220/255, green: 31/255, blue: 255/255, alpha: 1)
        solana.mainColor = UIColor(red: 86/255, green: 144/255, blue: 214/255, alpha: 1)
//        solana.mainColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        let binance = Coin(name:"Binance Coin",symbol: "BNB", internalAssetID: 7)
        binance.mainColor = UIColor(red: 243/255, green: 186/255, blue: 47/255, alpha: 1)
        let usdCoin = Coin(name:"USDCoin",symbol: "USDC", internalAssetID: 8)
        usdCoin.mainColor = UIColor(red: 39/255, green: 117/255, blue: 202/255, alpha: 1)
        let algorand = Coin(name:"Algorand",symbol: "ALGO", internalAssetID: 9)
        algorand.mainColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        let polkadot = Coin(name:"Polkadot",symbol: "DOT", internalAssetID: 10)
        polkadot.mainColor = UIColor(red: 230/255, green: 0/255, blue: 122/255, alpha: 1)
        let bitcoinCash = Coin(name:"Bitcoin Cash",symbol: "BCH", internalAssetID: 11)
        bitcoinCash.mainColor = UIColor(red: 10/255, green: 193/255, blue: 142/255, alpha: 1)
        let monero = Coin(name:"Monero",symbol: "XMR", internalAssetID: 12)
        monero.mainColor = UIColor(red: 242/255, green: 103/255, blue: 36/255, alpha: 1)
        let uniswap = Coin(name:"Uniswap",symbol: "UNI", internalAssetID: 13)
        uniswap.mainColor = UIColor(red: 255/255, green: 0/255, blue: 152/255, alpha: 1)
        let shibainu = Coin(name:"Shiba Inu",symbol: "SHIB", internalAssetID: 14)
        shibainu.mainColor = UIColor(red: 255/255, green: 164/255, blue: 9/255, alpha: 1)
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
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        refreshControl.beginRefreshing()
        getCoinData(finished: firstTimeLoad)
        
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
            netWorthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -15),
            netWorthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            netChangeLabel.topAnchor.constraint(equalTo: netWorthLabel.bottomAnchor, constant: 15),
            netChangeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            netChangeImage.heightAnchor.constraint(equalToConstant: 15),
            netChangeImage.widthAnchor.constraint(equalToConstant: 15),
            netChangeImage.centerYAnchor.constraint(equalTo: netChangeLabel.centerYAnchor),
            netChangeImage.trailingAnchor.constraint(equalTo: netChangeLabel.leadingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            assetsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            assetsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            editAssestsButton.centerYAnchor.constraint(equalTo: assetsLabel.centerYAnchor),
            editAssestsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            editAssestsButton.heightAnchor.constraint(equalToConstant: 25),
            editAssestsButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            addAssestsButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 15),
            addAssestsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addAssestsButton.heightAnchor.constraint(equalToConstant: 60),
            addAssestsButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            walletButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            walletButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            walletButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            walletButton.widthAnchor.constraint(equalTo: portfolioButton.widthAnchor, multiplier: 4.0/3.0),
        ])
        
        NSLayoutConstraint.activate([
            portfolioButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
            portfolioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            portfolioButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            portfolioButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
        
        NSLayoutConstraint.activate([
            newsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
            newsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newsButton.widthAnchor.constraint(equalTo: portfolioButton.widthAnchor, multiplier: 0.8),
            newsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05625),
        ])
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    @objc func pushEditScreen(){
        let coinEditor = EditCoinController()
        coinEditor.parentController = self
        navigationController?.pushViewController(coinEditor, animated: true)
    }
    
    @objc func presentAddScreen(){
        let presenter = AddCoinController()
        presenter.parentController = self
        present(presenter, animated: true, completion: nil)
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
        if amount < 0 {
            return "\(round(-amount * 10)/10.0)%"
        }
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
        if oldWorth != 0{
            netChange = ((netWorth/oldWorth) - 1) * 100
        }
        netChangeLabel.text = self.getRoundedPercentage(amount: netChange)
        netChangeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        netChangeImage.image = nil
        if ((round(netChange * 10)/10.0) > 0){
            netChangeLabel.textColor = UIColor(red: 142/255, green: 236/255, blue: 127/255, alpha: 1)
            netChangeImage.image = UIImage(named: "green_arrow")
        }
        if ((round(netChange * 10)/10.0) < 0){
            netChangeLabel.textColor = UIColor(red: 255/255, green: 138/255, blue: 138/255, alpha: 1)
            netChangeImage.image = UIImage(named: "red_arrow")
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
    
    func firstTimeLoad(){
        if firstTimeLoading {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.updateMyCoins()
                self.updateNetWorthAndNetChange()
                self.refreshControl.endRefreshing()
            }
            firstTimeLoading = false
        }
    }
    
    @objc func refresh(){
        getCoinData(finished: {})
        updateNetWorthAndNetChange()
        refreshControl.endRefreshing()
    }
    
    func getCoinData(finished: @escaping ()->()) {
        NetworkManager.getAllCoinValues(completion: { (data,error) in
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
            }, finished: finished)
        
        NetworkManager.getOldCoinValues(completion: { (data,error) in
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
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }, finished: finished)
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
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinView = SingleCoinViewController()
        let coin = myCoins[indexPath.row]
        coinView.parentController = self
        coinView.parentCoin = coin
        navigationController?.pushViewController(coinView, animated: true)
    }
}
