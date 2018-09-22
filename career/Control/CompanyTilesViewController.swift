//
//  CompanyTilesViewController.swift
//  career
//
//  Created by Connor Svrcek on 9/22/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit

class CompanyTilesViewController: UICollectionViewController {
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
    }
}
