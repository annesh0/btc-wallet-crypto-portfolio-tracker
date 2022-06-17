//
//  ArticleTableViewCell.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/17/22.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var articleImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        articleImage.contentMode = .scaleAspectFit
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleImage)
        
        setupConstraints()
    }

    func configure(article: Article) {
        articleImage.image = article.articleImage
        titleLabel.text = article.articleTitle
        dateLabel.text = article.articleDate
    }

    func setupConstraints() {
        let padding: CGFloat = 15
        let labelHeight: CGFloat = 25

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: padding),
            titleLabel.centerYAnchor.constraint(equalTo: articleImage.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            articleImage.heightAnchor.constraint(equalToConstant: 75),
            articleImage.widthAnchor.constraint(equalToConstant: 75),
            articleImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding)
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
