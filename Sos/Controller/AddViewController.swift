//
//  AddViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/31.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numberTextField: UITextField!
    
    var tableViewController = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.keyboardType = .numberPad
        // Do any additional setup after loading the view.
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if nameTextField.text != "" {
           
            contact.append(Contact(relationship: nameTextField.text!, number: numberTextField.text!))
            navigationController?.popViewController(animated: true)
    
        } else {
            nameTextField.placeholder = "이름을 입력하시오"
        }
        
    }
}

