//
//  AddViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/31.
//

import UIKit

let DidDismissPostCommentViewController: Notification.Name = Notification.Name("DidDismissPostCommentViewController")

class AddViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var numberTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.keyboardType = .numberPad
        // Do any additional setup after loading the view.
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if nameTextField.text != "" {
            contact.append(Contact(relationship: nameTextField.text!, number: numberTextField.text!))
            NotificationCenter.default.post(name: DidDismissPostCommentViewController, object: nil, userInfo: nil)
            self.dismiss(animated: true) {
                print("error")
            }
            
           
        } else {
            nameTextField.placeholder = "이름을 입력하시오"
        }
        
    }
}

