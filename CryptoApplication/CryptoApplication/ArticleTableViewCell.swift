//
//  ArticleTableViewCell.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/17/22.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {

    var titleLabel = UITextView()
    var dateLabel = UILabel()
    var publishLabel = UITextView()
    var articleImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.isEditable = false
        titleLabel.isSelectable = false
        titleLabel.isScrollEnabled = true
        titleLabel.isUserInteractionEnabled = false
        titleLabel.textContainer.maximumNumberOfLines = 3
        titleLabel.textContainer.lineBreakMode = .byTruncatingTail
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        publishLabel.font = .systemFont(ofSize: 12, weight: .bold)
        publishLabel.isEditable = false
        publishLabel.isSelectable = false
        publishLabel.isScrollEnabled = true
        publishLabel.isUserInteractionEnabled = false
        publishLabel.textContainer.maximumNumberOfLines = 1
        publishLabel.textContainer.lineBreakMode = .byTruncatingTail
        publishLabel.translatesAutoresizingMaskIntoConstraints = false
        publishLabel.textColor = .systemGray
        contentView.addSubview(publishLabel)
        
        dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .systemGray
        contentView.addSubview(dateLabel)

        articleImage.contentMode = .scaleAspectFit
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleImage)
        
        setupConstraints()
    }

    func configure(article: Article) {
        articleImage.image = article.articleImage
        titleLabel.text = article.articleTitle
        publishLabel.text = "From: " + article.publisher!
        dateLabel.text = article.articleDate
    }

    func setupConstraints() {
        let padding: CGFloat = 15
        let labelHeight: CGFloat = 25

        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: articleImage.leadingAnchor, constant: -padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            publishLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            publishLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            publishLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -5),
            publishLabel.heightAnchor.constraint(equalToConstant: labelHeight)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: articleImage.leadingAnchor, constant: -padding),
            dateLabel.centerYAnchor.constraint(equalTo: publishLabel.centerYAnchor, constant: 3.5),
            dateLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
        
        NSLayoutConstraint.activate([
            articleImage.heightAnchor.constraint(equalToConstant: 100),
            articleImage.widthAnchor.constraint(equalToConstant: 120),
            articleImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
