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
    var articleImage: UIImage? = UIImage(named: "anon")
    var articleDate: String?
    var url: URL?
    var publisher: String? = ""
    
    init(){}
}
