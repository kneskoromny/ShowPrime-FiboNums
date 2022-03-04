//
//  NumberViewModel.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import Foundation

final class NumberViewModel {
    
    var nums: Box<[Num]> = Box([])
    var viewType = K.ViewType.prime
    var startNum = 0
    
    private var prevDark = (far: false, near: true)
    private let numsForBatch = 200
    
    // MARK: - Initializer
    init() {
        loadBatchPrimes()
    }
    
    // MARK: - Public
    func loadBatchPrimes() {
        let finalNum = startNum + numsForBatch
        let startArr: [Int] = Array(startNum...finalNum)

        DispatchQueue.global().async { [self] in
            
            startArr.filter { num in
                self.isPrime(num)
            }.forEach { filteredNum in
                let colored = self.getColored(dependsOf: prevDark)
                
                let primeNum = Num(title: filteredNum, colored: colored)
                self.nums.value.append(primeNum)
            }
        }
    }
    // TODO: try load batches
    func loadBatchFibos() {
        DispatchQueue.global().async { [self] in
            
            for i in 0..<92 {
                let result = getFibo(of: i)
                let colored = self.getColored(dependsOf: prevDark)
                let fiboNum = Num(title: result, colored: colored)
                nums.value.append(fiboNum)
            }
            //print("numbers: \(numbers)")
            //print("fibo numbers: \(nums.value)")
        }
    }
    
    // MARK: - Private
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
    
    private func getFibo(of number: Int) -> Int {
        var first = 0
        var second = 1

        for _ in 0..<number {
            let previous = first
            first = second
            second = previous + first
        }

        return first
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
