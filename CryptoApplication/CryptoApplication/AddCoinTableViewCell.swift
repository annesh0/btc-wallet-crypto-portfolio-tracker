//
//  CoinTableViewCell.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//


import UIKit

class AddCoinTableViewCell: UITableViewCell {

    var addOrRemoveLabel = UILabel()
    var symbolLabel = UILabel()
    var nameLabel = UILabel()
    var logoImage = UIImageView()
    
    var labelColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        addOrRemoveLabel.font = .systemFont(ofSize: 22, weight: .bold)
        addOrRemoveLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addOrRemoveLabel)
        
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        symbolLabel.font = .systemFont(ofSize: 20, weight: .bold)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(symbolLabel)

        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoImage)
        
        setupConstraints()
    }

    func configure(coin: Coin) {
        if coin.isChosen{
            addOrRemoveLabel.text = "Remove"
        }
        else {
            addOrRemoveLabel.text = "Add"
        }
        
        symbolLabel.text = coin.symbol
        symbolLabel.textColor = labelColor
        nameLabel.text = coin.name
        logoImage.image = coin.logoImage
    }

    func setupConstraints() {
        let padding: CGFloat = 15
        let labelHeight: CGFloat = 25

        NSLayoutConstraint.activate([
            addOrRemoveLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding * 2),
            addOrRemoveLabel.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            addOrRemoveLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: padding),
            nameLabel.bottomAnchor.constraint(equalTo: logoImage.centerYAnchor, constant: -4),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: padding),
            symbolLabel.topAnchor.constraint(equalTo: logoImage.centerYAnchor, constant: 4),
            symbolLabel.heightAnchor.constraint(equalToConstant: labelHeight)
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
