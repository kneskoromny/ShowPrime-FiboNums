//
//  ViewController.swift
//  ShowPrime&FiboNums
//
//  Created by Кирилл Нескоромный on 03.03.2022.
//

import UIKit

final class NumberViewController: UIViewController {
    
    var viewModel = NumberViewModel()
    
    // MARK: - UI elements
    let segmentedControl = UIElementsFactory.makeSegmentedControl(#selector(changeState))
    let collectionView = UIElementsFactory.makeCollectionView()
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        viewModel.nums.bind { primeNums in
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
    @objc func changeState(_ sender: UISegmentedControl) {
//        viewModel.nums.value = []
//        viewModel.isPrevCellsColored = (false, true)
        
        viewModel.refreshView()
        
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.viewType = K.ViewType.prime
            viewModel.loadBatchPrimes()
        case 1:
            viewModel.viewType = K.ViewType.fibo
            viewModel.loadBatchFibos()
        default:
            break
        }
    }
}

// MARK: - CollectionView data source
extension NumberViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.nums.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == viewModel.nums.value.count - 1 {
            switch viewModel.viewType {
            case .prime:
                viewModel.startNum += 200
                viewModel.loadBatchPrimes()
            case .fibo:
                viewModel.startNum += 20
                viewModel.loadBatchFibos()
            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellID, for: indexPath) as! NumCell
        let num = viewModel.nums.value[indexPath.row]
        
        cell.label.text = String(num.title)
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


