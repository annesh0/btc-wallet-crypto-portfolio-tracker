//
//  NewsViewController.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/17/22.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
        
    let gradient1 = CAGradientLayer()
    let gradient2 = CAGradientLayer()
    
    let refreshControl = UIRefreshControl()
    var tableView = UITableView()
    let reuseIdentifier = "newsCellReuse"
    var articles: [Article] = []
    
    var titleLabel = UILabel()
    
    var walletButton = UIButton()
    var portfolioButton = UIButton()
    var newsButton = UIButton()
    let isoFormatter = ISO8601DateFormatter()
    let realDate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd"
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
    
    var loadedPortfolioScreen: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        let blueColor = UIColor(red: 169/255, green: 196/255, blue: 238/255, alpha: 1)
        let midPointColor = UIColor(red: 169/255, green: 196/255, blue: 238/255, alpha: 0.99)
        gradient1.frame = CGRect(x:0, y:0, width: view.frame.width, height: 50)
        gradient1.colors = [blueColor.cgColor, midPointColor.cgColor]
        view.layer.insertSublayer(gradient1, at: 0)
        gradient2.frame = CGRect(x:0, y:50, width: view.frame.width, height: 150)
        gradient2.colors = [midPointColor.cgColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient2, at: 0)
        
        titleLabel.text = "Latest News"
        titleLabel.font = .systemFont(ofSize: 35, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        walletButton.setBackgroundImage(UIImage(named: "wallet1"), for: .normal)
        walletButton.backgroundColor = .white
        walletButton.addTarget(self, action: #selector(walletButtonPress), for: .touchUpInside)
        walletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletButton)
        
        portfolioButton.setBackgroundImage(UIImage(named: "portfolio1"), for: .normal)
        portfolioButton.backgroundColor = .white
        portfolioButton.translatesAutoresizingMaskIntoConstraints = false
        portfolioButton.addTarget(self, action: #selector(portfolioButtonPress), for: .touchUpInside)
        view.addSubview(portfolioButton)
        
        newsButton.setBackgroundImage(UIImage(named:"news2"), for: .normal)
        newsButton.backgroundColor = .white
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        refreshControl.beginRefreshing()
        //self.getArticleData()
        
        setupConstraints()
    }

    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -85)
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
    
    @objc func portfolioButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedPortfolioScreen!)
    }
    
    
    @objc func walletButtonPress(){
        self.view.window?.rootViewController = UINavigationController(rootViewController: self.loadedPortfolioScreen!.loadedWalletScreen)
    }
    
    @objc func refresh(){
        getArticleData()
        refreshControl.endRefreshing()
    }
    
    func getArticleData() {
        NetworkManager.getNewsArticles(completion: { (data,error) in
            var articles: [String:Any] = [:]
            articles = data as! [String : Any]
            self.getArticles(articleDictionary: articles)
        }, finished: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    func getArticles(articleDictionary: [String:Any]){
        articles = []
        let data = articleDictionary["articles"] as! [[String:Any]]
        var limit = 20
        if data.count < limit{
            limit = data.count
        }
        var counter = 0
        if limit > 0
        {
            for i in 0...limit-1{
                var canContinue = true
                for article in articles{
                    if article.articleTitle == data[i]["title"] as! String?{
                        canContinue = false
                        counter += 1
                        if limit < data.count{
                            limit += 1
                        }
                    }
                }
                if canContinue{
                    articles.append(Article())
                    articles[i - counter].articleTitle = data[i]["title"] as! String?
                    if let publishedAtString = data[i]["publishedAt"] as! String? {
                        if let date = isoFormatter.date(from: publishedAtString){
                            articles[i - counter].articleDate = realDate.string(from: date)
                        }
                    }
                    let articleURL = data[i]["url"] as! String
                    articles[i - counter].url = URL(string: articleURL)
                    if let imageURL = data[i]["urlToImage"] {
                        if imageURL is NSNull {

                        } else {
                            let data = try? Data(contentsOf: URL(string: imageURL as! String)!)
                            if let imageData = data{
                                articles[i - counter].articleImage = UIImage(data: imageData)
                            }
                        }
                    }
                    if let source = data[i]["source"] as? [String: String] {
                        articles[i - counter].publisher = source["name"]
                    }
                    else {
                        articles[i - counter].publisher = "Unavailible"
                    }
                }
            }
        }
    }
}

extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ArticleTableViewCell {
                let article = articles[indexPath.row]
                cell.configure(article: article)
                cell.selectionStyle = .none
                return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let thisURL = articles[indexPath.row].url{
            UIApplication.shared.open(thisURL)
        }
    }
}
