//
//  ViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/19.
//

import UIKit
import AVFoundation


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
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(counter), userInfo: nil, repeats : true)
        print("h")
    }

    @IBAction func btnSosUp(_ sender: UIButton) {
        timer.invalidate()
        print("h")
    }
    
    @objc func counter() {
        timer.invalidate()
        self.performSegue(withIdentifier: "sosResult", sender: self)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
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



