//
//  SendController.swift
//  CryptoApplication
//
//  Created by Dylan McCreesh on 7/20/22.
//

import Foundation
import UIKit

class SendContoller: UIViewController {
    
    weak var parentController: WalletViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 169/255, green: 196/255, blue: 238/255, alpha: 1)
        
        setupConstraints()
    }

    func setupConstraints(){
        
    }
    
}
