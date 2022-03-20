//
//  ViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/19.
//

import UIKit

class MainViewController: UIViewController{
        
        @IBOutlet var mSwitch: UISwitch!
        @IBOutlet var lblSiren: UILabel!
        var timer = Timer()
        var siren = true
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            mSwitch.tintColor = UIColor.white
            mSwitch.layer.cornerRadius = mSwitch.frame.height / 2.0
        mSwitch.backgroundColor = UIColor.white
        mSwitch.clipsToBounds = true
         
    }

   
    
    @IBAction func btnSosDown(_ sender: UIButton) {
        print("누를떄")
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(counter), userInfo: nil, repeats : true)
    }

    @IBAction func btnSosUp(_ sender: UIButton) {
        print("땔대")
        timer.invalidate()
    }
    
    @objc func counter() {
        print("실행완료")
        timer.invalidate()
        self.performSegue(withIdentifier: "sosResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sosResult"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.siren = self.siren
        }
    }
    
    @IBAction func siren(_ sender: UISwitch) {
        if sender.isOn{
            lblSiren.text = "신호재생 ON"
            siren = true
        } else {
            lblSiren.text = "신호재생 OFF"
            siren = false
        }
    }
    
}

