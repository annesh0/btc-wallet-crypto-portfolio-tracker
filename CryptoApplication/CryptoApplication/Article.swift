//
//  Article.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 6/17/22.
//

import Foundation
import UIKit

class Article {
    var articleTitle: String?
    var articleImage: UIImage?
    var articleDate: String?
    
    init(title: String, image: UIImage, date: String){
        self.articleTitle = title
        self.articleImage = image
        self.articleDate = date
    }
}
