//
//  CompanyCellsViewController.swift
//  career
//
//  Created by Connor Svrcek on 9/22/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit
import Firebase

class CompanyCellsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let cellID = "cellID"
    
    var collectionView: UICollectionView!
    
    var colRef: CollectionReference!
    
    let refresh = UIRefreshControl()
    
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
        
        setupNavigation()
        //setupRefresh()

        colRef = Firestore.firestore().collection("CareerFair/r1i802xAhNxJg7BrdYbu/Company")
        fetchDocuments()
    }
    
    // Setup refresh controller
    func setupRefresh() {
        // Add Refresh Control to CollectionView
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refresh
        } else {
            collectionView.addSubview(refresh)
        }
        
        refresh.addTarget(self, action: #selector(fetchDocuments), for: .valueChanged)
    }
    
    @objc func fetchDocuments() {
        if fair.companies.isEmpty {
            colRef.getDocuments { (querySnapshot, error) in
                if error != nil {
                    print("Error fetching documents")
                } else {
                    for documents in querySnapshot!.documents {
                        let docData = documents.data()
                        let name = docData["companyName"] as! String
                        print("name = \(name)")
                        let newCompany = Company()
                        newCompany.name = name
                        self.fair.companies.append(newCompany)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(GetInLine(company: fair.companies[indexPath.row], colRef: colRef!, compIndex: indexPath.row), animated: true)
        
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
        cell.nameLabel.text = fair.companies[indexPath.item].name
        
        
        // Adding rounded corners
        cell.contentView.layer.cornerRadius = 7.0
        cell.contentView.layer.borderWidth = 3.0
        cell.contentView.layer.borderColor = UIColor.white.cgColor
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fair.companies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = (view.frame.width / 2) - 20
        return CGSize(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
}




