//
//  CoinTableViewCell.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//


import UIKit

class CoinTableViewCell: UITableViewCell {

    var nameLabel = UILabel()
    var amountCoinLabel = UILabel()
    var amountUSDLabel = UILabel()
    var changeLabel = UILabel()
    var logoImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        amountCoinLabel.font = .systemFont(ofSize: 18, weight: .bold)
        amountCoinLabel.textColor = .lightGray
        amountCoinLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountCoinLabel)
        
        amountUSDLabel.font = .systemFont(ofSize: 20, weight: .bold)
        amountUSDLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountUSDLabel)
        
        changeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.textColor = .lightGray
        contentView.addSubview(changeLabel)

        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoImage)
        
        setupConstraints()
    }

    func configure(coin: Coin) {
        nameLabel.text = coin.name
        amountCoinLabel.text = coin.getCurrencyForm(amount: coin.amountCoin) + " " + coin.symbol
        amountUSDLabel.text = "$" + coin.getCurrencyForm(amount: coin.amountUSD)
        changeLabel.text = coin.getRoundedPercentage(amount: coin.percentChnage)
        changeLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        if (coin.percentChnage > 0){
            changeLabel.textColor = UIColor(red: 142/255, green: 236/255, blue: 127/255, alpha: 1)
        }
        if (coin.percentChnage < 0){
            changeLabel.textColor = UIColor(red: 255/255, green: 138/255, blue: 128/255, alpha: 1)
        }
        logoImage.image = coin.logoImage
    }

    func setupConstraints() {
        let padding: CGFloat = 15
        let labelHeight: CGFloat = 20

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            amountCoinLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            amountCoinLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            amountCoinLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            amountUSDLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            amountUSDLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            amountUSDLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            changeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            changeLabel.centerYAnchor.constraint(equalTo: amountCoinLabel.centerYAnchor),
            changeLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 75),
            logoImage.widthAnchor.constraint(equalToConstant: 75),
            logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
