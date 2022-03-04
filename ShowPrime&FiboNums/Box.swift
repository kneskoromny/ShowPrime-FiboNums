//
//  Box.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 04.03.2022.
//

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
