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
        // Color for testing
        view.backgroundColor = UIColor.orange
        
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CompanyCell.self, forCellWithReuseIdentifier: cellID)
        
        let company = Company()
        company.name = "ally"
        fair.companies = [company]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CompanyCell
        cell.nameLabel.text = fair.companies?[indexPath.item].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (fair.companies?.count)!
    }
}
