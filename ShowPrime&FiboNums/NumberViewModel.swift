//
//  NumberViewModel.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import Foundation

class NumberViewModel {
    
    var primeNums: Box<[Num]> = Box([])
    var startNumber = 0
    
    private let numsForBatch = 200
    
    // MARK: - Initializer
    init() {
        loadBatch()
    }
    
    // MARK: - Methods
    func loadBatch() {
        let finalNumber = startNumber + numsForBatch
        let startArr: [Int] = Array(startNumber...finalNumber)
        
        DispatchQueue.global().async {
            
            startArr.filter { num in
                self.isPrime(num)
            }.forEach { filteredNum in
                let primeNum = Num(title: String(filteredNum))
                self.primeNums.value.append(primeNum)
            }
        }
    }
    
    
    func ind(n: Int) -> [Int] {
        var array = [0]
        (4...n).forEach { num in
            if num % 4 == 0 {
                let prevNum = num - 1
                array.append(prevNum)
                array.append(num)
            }
        }
        return array
    }
    
    private func isPrime(_ num: Int) -> Bool {
        guard num > 1 else { return false }
        for iteration in 2..<num {
            if num % iteration == 0 {
                return false
            }
        }
        return true
    }
}
