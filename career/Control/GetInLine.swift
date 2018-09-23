//
//  GetInLine.swift
//  career
//
//  Created by Julian Shomali on 9/23/18.
//  Copyright © 2018 Connor Svrcek. All rights reserved.
//

import UIKit
import Firebase

class GetInLine: UIViewController {
    
    var company: Company
    var colRef = Firestore.firestore().collection("/CareerFair/r1i802xAhNxJg7BrdYbu/Company/GO6aFoYK5VQLrzGeBLrE/Queue/vETzHjhIQesVrRgtgAMP/User")
    var compIndex: Int
    
    var docReg: DocumentReference?
    
    init(company: Company, compIndex: Int) {
        self.company = company
        self.compIndex = compIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var numberButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneNumberField, formatLabel, lineButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var phoneNumberField: UITextField = {
        let number = UITextField()
        number.textColor = UIColor.white
        number.attributedPlaceholder = NSAttributedString(string: "Enter Phone Number", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 24)!])
        number.font = UIFont(name: "Helvetica-Bold", size: 24)
        number.textAlignment = .center
        
        number.layer.borderWidth = 3.0
        number.layer.borderColor = UIColor.white.cgColor
        number.layer.cornerRadius = 7.0
        return number
    }()
    
    let formatLabel: UILabel = {
        let format = UILabel()
        format.text = "Format: XXXXXXXXXX"
        format.textColor = UIColor.white
        format.font = UIFont(name: "Helvetica-Bold", size: 18)
        format.textAlignment = .left
        return format
    }()
    
    lazy var lineButton: UIButton = {
        let button = UIButton.init(type: .roundedRect)
        button.backgroundColor = .orange
        button.setTitle("Get In Line", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 32)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 7.0
        return button
    }()
    
    func setupStack() {
        numberButtonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberButtonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 75).isActive = true
        numberButtonStack.heightAnchor.constraint(equalToConstant: 225).isActive = true
        numberButtonStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        navigationItem.title = "\(company.name ?? "")"
        
        view.addSubview(numberButtonStack)
        setupStack()
    }
    
    func makeDocReg(newPerson: Person) {
        self.colRef.addDocument(data: [
            "linePosition": self.company.Queue.count,
            "phoneNumber": newPerson.phoneNumber!,
            "status": "open",
            "userName": ""
        ]) { (err) in
            if err != nil {
                print("Error fetching documents")
            }
        }
        
        self.phoneNumberField.text = ""
        self.phoneNumberField.attributedPlaceholder = NSAttributedString(string: "Successfully added to queue.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 18)!])
    
    }
    
    @objc func buttonAction(sender: UIButton!) {
        // Check if the number is long enough
        if (phoneNumberField.text?.count)! < 10 && (phoneNumberField.text?.count)! != 0 {
            phoneNumberField.text = ""
            phoneNumberField.placeholder = "Please enter a valid phone number."
            return
        }
        
        // Check if characters are all numbers
        for unicode in (phoneNumberField.text?.unicodeScalars)! {
            if CharacterSet.letters.contains(unicode) {
                phoneNumberField.text = ""
                phoneNumberField.placeholder = "Please enter a valid phone number."
                return
            }
        }
        
        // Successfully added to queue
        let newPerson = Person()
        newPerson.phoneNumber = phoneNumberField.text
        company.Queue.append(newPerson)
        
        // Post to Firestore
        makeDocReg(newPerson: newPerson)
        
    }
    
    
    
}
