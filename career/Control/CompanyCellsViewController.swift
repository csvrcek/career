//
//  CompanyCellsViewController.swift
//  career
//
//  Created by Connor Svrcek on 9/22/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit

class CompanyCellsViewController: UICollectionViewController {
    let cellID = "cellID"
    
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
        collectionView.register(CompanyCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let company = Company()
        company.name = "ally"
        fair.companies = [company]
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CompanyCell
        cell.nameLabel.text = fair.companies?[indexPath.item].name
        
        return cell
    }
}
