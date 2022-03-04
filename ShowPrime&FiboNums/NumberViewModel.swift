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
    
    var prevDark = (far: false, near: true)
    var currDark = true
    
    private let numsForBatch = 200
    
    // MARK: - Initializer
    init() {
        loadBatchPrimes()
    }
    
    // MARK: - Methods
    func loadBatchPrimes() {
        let finalNumber = startNumber + numsForBatch
        let startArr: [Int] = Array(startNumber...finalNumber)

        DispatchQueue.global().async { [self] in
            
            startArr.filter { num in
                self.isPrime(num)
            }.forEach { filteredNum in
                let title = String(filteredNum)
                let colored = self.getColored(dependsOf: prevDark)
                
                let primeNum = Num(title: title, colored: colored)
                self.primeNums.value.append(primeNum)
            }
        }
    }
    
    private func getColored(dependsOf previous: (Bool, Bool)) -> Bool {
        var current = true
        if previous.0 && previous.1
        || previous.0 && !previous.1 {
            current = false
        }
        prevDark.far = previous.1
        prevDark.near = current
        
        return current
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
