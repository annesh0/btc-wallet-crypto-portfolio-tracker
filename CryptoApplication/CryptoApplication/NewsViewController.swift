//
//  NewsViewController.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/17/22.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    var padding = UITextView()
    
    let refreshControl = UIRefreshControl()
    var tableView = UITableView()
    let reuseIdentifier = "newsCellReuse"
    var articles: [Article] = []
    
    var titleLabel = UILabel()
    var newsLabel = UILabel()
    
    var walletButton = UIButton()
    var portfolioButton = UIButton()
    var newsButton = UIButton()
    var borderBuffer = UITextView()
    let isoFormatter = ISO8601DateFormatter()
    let realDate: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .white
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        padding.isEditable = false
        padding.isSelectable = false
        padding.isScrollEnabled = false
        padding.backgroundColor = .lightGray
        padding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(padding)
        titleLabel.text = "News"
        titleLabel.font = .systemFont(ofSize: 35, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        newsLabel.text = "Articles:"
        newsLabel.font = .systemFont(ofSize: 30, weight: .bold)
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsLabel)
        walletButton.backgroundColor = .white
        walletButton.layer.borderColor = UIColor.lightGray.cgColor
        walletButton.layer.borderWidth = 0.5
        walletButton.layer.cornerRadius = 0
        walletButton.addTarget(self, action: #selector(walletButtonPress), for: .touchUpInside)
        walletButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletButton)
        portfolioButton.backgroundColor = .white
        portfolioButton.layer.borderColor = UIColor.lightGray.cgColor
        portfolioButton.layer.borderWidth = 0.5
        portfolioButton.layer.cornerRadius = 0
        portfolioButton.addTarget(self, action: #selector(portfolioButtonPress), for: .touchUpInside)
        portfolioButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(portfolioButton)
        newsButton.backgroundColor = .lightGray
        newsButton.layer.borderColor = UIColor.lightGray.cgColor
        newsButton.layer.borderWidth = 0.5
        newsButton.layer.cornerRadius = 0
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsButton)
        borderBuffer.isEditable = false
        borderBuffer.isSelectable = false
        borderBuffer.isScrollEnabled = false
        borderBuffer.backgroundColor = .lightGray
        borderBuffer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(borderBuffer)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        getArticleData()
        
        setupConstraints()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            padding.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            padding.topAnchor.constraint(equalTo: view.topAnchor),
            padding.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            padding.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: padding.bottomAnchor, constant: 15),
            newsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: newsLabel.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -85)
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
    
    @objc func portfolioButtonPress(){
        let root = ViewController()
        self.view.window?.rootViewController = UINavigationController(rootViewController: root)
    }
    
    @objc func walletButtonPress(){
        let root = WalletViewController()
        self.view.window?.rootViewController = UINavigationController(rootViewController: root)
    }
    
    @objc func refresh(){
        getArticleData()
        refreshControl.endRefreshing()
    }
    
    func getArticleData() {
        NetworkManager.getNewsArticles{ (data,error) in
            var articles: [String:Any] = [:]
            articles = data as! [String : Any]
            self.getArticles(articleDictionary: articles)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getArticles(articleDictionary: [String:Any]){
        articles = []
        let data = articleDictionary["articles"] as! [[String:Any]]
        var limit = 20
        if data.count < 20{
            limit = data.count
        }
        var counter = 0
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
                        print("this is date item for article \(i - counter)")
                        print(date)
                        articles[i - counter].articleDate = realDate.string(from: date)
                    }
                }
                let articleURL = data[i]["url"] as! String
                articles[i - counter].url = URL(string: articleURL)
                //let imageURL = data[i]["urlToImage"] as! String?
                if let imageURL = data[i]["urlToImage"] {
                    if imageURL is NSNull {
                        
                    } else {
                        let data = try? Data(contentsOf: URL(string: imageURL as! String)!)
                        if let imageData = data{
                            articles[i - counter].articleImage = UIImage(data: imageData)
                        }
                    }
                }
                /*
                if imageURL == nil {  } else{
                    let data = try? Data(contentsOf: URL(string: imageURL!)!)
                    if let imageData = data{
                        articles[i - counter].articleImage = UIImage(data: imageData)
                    }
                }
                 */
                let source = data[i]["source"] as! [String: String]
                articles[i - counter].publisher = source["name"]
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
            print("this happened")
            return UITableViewCell()
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let thisURL = articles[indexPath.row].url{
            UIApplication.shared.open(thisURL)
        }
    }
}
