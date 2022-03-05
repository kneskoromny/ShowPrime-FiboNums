//
//  Constants.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import UIKit

enum K {
    
    static let appName = "show prime & fibonacci"
    static let cellID = "NumCell"
    
    enum Colors {
        static let dark = UIColor.label
        static let light = UIColor.systemGray5
        static let white = UIColor.systemBackground
    }
    
    enum Batch {
        static let prime = 200
        static let fibo = 20
    }
    
    enum ViewType {
        case prime
        case fibo
    }
}
