//
//  CompanyCell.swift
//  career
//
//  Created by Julian Shomali on 9/22/18.
//  Copyright © 2018 Julian Shomali. All rights reserved.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.white
        name.textAlignment = .center
        name.font = UIFont(name: "Helvetica-Bold", size: 32)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 2
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
        contentView.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContentView() {
        contentView.addSubview(nameLabel)
        
        nameLabel.center = contentView.center
        
        nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
    
    
    
}
