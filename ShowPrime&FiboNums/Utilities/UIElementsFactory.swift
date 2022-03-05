//
//  UIElementsFactory.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import UIKit

struct UIElementsFactory {
    
    static func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(NumCell.self, forCellWithReuseIdentifier: K.cellID)
        return cv
    }
    
    static func makeLabel() -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 30)
        l.textAlignment = .center
        l.adjustsFontSizeToFitWidth = true
        return l
    }
    
    static func makeSegmentedControl(_ action: Selector) -> UISegmentedControl {
        let items = ["prime", "fibo"]
        let sg = UISegmentedControl(items: items)
        sg.translatesAutoresizingMaskIntoConstraints = false
        sg.selectedSegmentIndex = 0
        sg.addTarget(self, action: action, for: .valueChanged)
        return sg
    }
}
