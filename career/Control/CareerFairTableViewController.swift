//
//  CareerFairViewController.swift
//  career
//
//  Created by Connor Svrcek on 9/22/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CareerFairTableViewController: UITableViewController {
    
    let fairs = Array<Fair>()
    
    let databaseRef = 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationItem.title = "Career Fairs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fair = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        return fair
    }
}
