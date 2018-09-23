//
//  CompanyCellsViewController.swift
//  career
//
//  Created by Connor Svrcek on 9/22/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit

class CompanyCellsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let cellID = "cellID"
    
    var collectionView: UICollectionView!
    
    init(fair_in: Fair) {
        self.fair = fair_in
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fair = Fair()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        let company = Company()
        company.name = "ally"
        fair.companies = [company]
        
        setupNavigation()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(GetInLine(company: (fair.companies?[indexPath.row])!), animated: true)
        
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CompanyCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = UIColor.orange
        
        view.addSubview(collectionView)
    }
    
    func setupNavigation() {
        navigationItem.title = "\(fair.name!)"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CompanyCell
        cell.nameLabel.text = fair.companies?[indexPath.item].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (fair.companies?.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = (view.frame.width / 2) - 20
        return CGSize(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
}




