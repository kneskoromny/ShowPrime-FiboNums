//
//  NumCell.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import UIKit

class NumCell: UICollectionViewCell {
    
    let label = UIElementsFactory.makeLabel()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("Не реализован кодер")
    }
    
    func addLabel() {
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            //label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            label.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -8),
            
        ])
    }
}
