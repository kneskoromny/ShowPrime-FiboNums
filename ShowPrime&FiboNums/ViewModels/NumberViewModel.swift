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
    var isPrevCellsColored = (far: false, near: true)
    
    private let primeBatch = K.Batch.prime
    private let fiboBatch = K.Batch.fibo
    
    // MARK: - Initializer
    init() {
        loadBatchPrimes()
    }
    
    // MARK: - Public
    func loadBatchPrimes() {
        let finalNum = startNum + primeBatch
        let startArr: [Int] = Array(startNum...finalNum)

        DispatchQueue.global().async { [self] in
            
            startArr.filter { num in
                self.isPrime(num)
            }.forEach { filteredNum in
                let colored = self.isColored(dependsOf: isPrevCellsColored)
                
                let primeNum = Num(title: filteredNum, colored: colored)
                self.nums.value.append(primeNum)
            }
        }
    }
    
    func loadBatchFibos() {
        let finalNum = startNum + fiboBatch
        
        DispatchQueue.global().async { [self] in
            
            for i in startNum..<finalNum where finalNum < 101 {
                guard i < 92 else { return }
                
                let fibo = getFibo(of: i)
                let colored = self.isColored(dependsOf: isPrevCellsColored)
                let fiboNum = Num(title: fibo, colored: colored)
                nums.value.append(fiboNum)
            }
        }
    }
    
    func refreshView() {
        nums.value = []
        isPrevCellsColored = (false, true)
        startNum = 0
    }
    
    // MARK: - Private
    private func isColored(dependsOf previous: (Bool, Bool)) -> Bool {
        var current = true
        if previous.0 && previous.1
        || previous.0 && !previous.1 {
            current = false
        }
        isPrevCellsColored.far = previous.1
        isPrevCellsColored.near = current
        
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
