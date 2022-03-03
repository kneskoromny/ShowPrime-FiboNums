//
//  ViewController.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    let data = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"
    ]
    
    lazy var indexes: [Int] = {
        return ind(n: 20)
    }()
    
    let segmentedControl = UIElementsFactory.makeSegmentedControl(#selector(changeData))
    let collectionView = UIElementsFactory.makeCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        print(indexes)
    }
    
    // MARK: - Layout
    private func setupView() {
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(
                equalTo: view.layoutMarginsGuide.topAnchor),
            segmentedControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(
                equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            
            collectionView.topAnchor.constraint(
                equalTo: segmentedControl.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
    }
    
    // MARK: - Methods
    @objc func changeData(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: print("I show prime")
        case 1: print("I show fibo")
        default: break
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
}

// MARK: - CollectionView data source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellID, for: indexPath) as! NumCell
        let index = indexPath.row
        let num = data[index]
        
        cell.label.text = num
        if indexes.contains(index) {
            cell.colored = true
        }
        cell.backgroundColor = cell.colored ? .systemGray3 : .systemBackground
        
        return cell
    }
}

// MARK: - CollectionView delegate flow layout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width
        let width = availableWidth / 2
        let height = width / 2
        
        return CGSize(width: width, height: height)
    }
    // вертикальный отступ
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}


