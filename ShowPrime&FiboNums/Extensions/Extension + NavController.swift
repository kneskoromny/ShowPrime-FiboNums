//
//  Extension + NavController.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 05.03.2022.
//

import UIKit

extension UINavigationController {
    func makeAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = K.Colors.light
        appearance.titleTextAttributes = [.foregroundColor: K.Colors.dark]
        
        return appearance
    }
}
