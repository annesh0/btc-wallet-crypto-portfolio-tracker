//
//  CoinTableViewCell.swift
//  practiceTableView
//
//  Created by Dylan McCreesh on 6/7/22.
//


import UIKit

class AddCoinTableViewCell: UITableViewCell {

    var nameLabel = UILabel()
    var logoImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoImage)
        
        setupConstraints()
    }

    func configure(coin: Coin) {
        if coin.isChosen{
            nameLabel.text = "Remove \(coin.name)?"
        }
        else {
            nameLabel.text = "Add \(coin.name)?"
        }
        logoImage.image = coin.logoImage
    }

    func setupConstraints() {
        let padding: CGFloat = 15
        let labelHeight: CGFloat = 25

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: padding),
            nameLabel.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight)
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
