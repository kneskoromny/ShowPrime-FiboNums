//
//  NumberViewModel.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import Foundation

class NumberViewModel {
    
    var primeNums = [Num]()
    var indexes = [0]
    
    func prime() {
        let startArr: [Int] = Array(2...10000)
        
        DispatchQueue.global().async {
            print(#function, "Current Thread: \(Thread.current)")
            
            let primeNumbers = startArr.filter { num in
                self.isPrime(num)
            }
            print("prime numbers: \(primeNumbers)")
            
//            startArr.forEach { index in
//                if index % 4 == 0 {
//                    let prevNum = index - 1
//                    self.indexes.append(prevNum)
//                    self.indexes.append(index)
//                }
//            }
//            print("indexes: \(self.indexes)")
        }
    }
    private func isPrime(_ num: Int) -> Bool {
        for iteration in 2..<num {
            if num % iteration == 0 {
                return false
            }
        }
        return true
    }
}
