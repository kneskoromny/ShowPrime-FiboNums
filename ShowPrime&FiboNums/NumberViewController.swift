//
//  ViewController.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import UIKit

class NumberViewController: UIViewController {
    
    
    let segmentedControl = UIElementsFactory.makeSegmentedControl(#selector(changeData))
    let collectionView = UIElementsFactory.makeCollectionView()
    
    var viewModel = NumberViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel.primeNums.bind { primeNums in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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
}

// MARK: - CollectionView data source
extension NumberViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.primeNums.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == viewModel.primeNums.value.count - 1 {
            viewModel.startNumber += 200
            viewModel.loadBatchPrimes()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellID, for: indexPath) as! NumCell
        let num = viewModel.primeNums.value[indexPath.row]
        
        cell.label.text = num.title
        cell.backgroundColor = num.colored ? K.Colors.dark : K.Colors.light
        
        return cell
    }
}

// MARK: - CollectionView delegate flow layout
extension NumberViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width
        let width = availableWidth / 2
        let height = width / 2
        
        return CGSize(width: width, height: height)
    }
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


