//
//  GetInLine.swift
//  career
//
//  Created by Julian Shomali on 9/23/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit

class GetInLine: UIViewController {
    
    var company: Company
    init(company: Company) {
        self.company = company
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: view.frame.midX - 200, y: view.frame.midY + 50, width: view.frame.width, height: 50))
        button.backgroundColor = .orange
        view.backgroundColor = .orange
        button.setTitle("Get In Line", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 32)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    
    
}
