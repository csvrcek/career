//
//  CareerFairViewController.swift
//  career
//
//  Created by Connor Svrcek on 9/22/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit
import Firebase

class CareerFairTableViewController: UITableViewController {
    
    private var fairs = Array<Fair>()
    
    var docRef: DocumentReference!
    
    let refresh = UIRefreshControl()
    
    let fairID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavigation()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: fairID)
        
        // Firestore setup
        docRef = Firestore.firestore().document("CareerFair/r1i802xAhNxJg7BrdYbu")
        
        fetchFromFirstore()
    }
    
    // Setup navigation controller
    func setupNavigation() {
        navigationItem.title = "Career Fairs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Setup refresh controller
    func setupRefresh() {
        // Add Refresh Control to CollectionView
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresh
        } else {
            tableView.addSubview(refresh)
        }
        
        refresh.addTarget(self, action: #selector(fetchFromFirstore), for: .valueChanged)
    }
    
    // Fetch from Firestore (from https://www.youtube.com/watch?v=rvxYRm6n_NM)
    @objc func fetchFromFirstore() {
        docRef.getDocument { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
            let careerFairsData = docSnapshot.data()
            let latestName = (careerFairsData!["careerFairName"] as! String)
            let newFair = Fair()
            newFair.name = latestName
            self.fairs.append(newFair)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fairs.count
    }
    
    func printFairs() {
        print("fairs = ")
        for i in fairs {
            print("\(i.name), ")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        printFairs()
        navigationController?.pushViewController(CompanyTilesViewController(fair_in: fairs[indexPath.row]), animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fairs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: fairID, for: indexPath)
        let fair = fairs[indexPath.row]
        cell.textLabel?.text = fair.name
        
        print("indexPath.row = \(indexPath.row)")
        
        return cell
    }
}
