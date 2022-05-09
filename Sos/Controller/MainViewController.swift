//
//  ViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/19.
//

import UIKit
import AVFoundation
import MessageUI
import CoreLocation


class MainViewController: UIViewController{
    
        @IBOutlet var mSwitch: UISwitch!
        @IBOutlet var lblSiren: UILabel!
        let locationManager = CLLocationManager()
        
        var strLocation = ""
        var nowLocation:CLLocation!
        var timer = Timer()
        var siren = true

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            mSwitch.tintColor = UIColor.white
            mSwitch.layer.cornerRadius = mSwitch.frame.height / 2.0
            mSwitch.backgroundColor = UIColor.white
            mSwitch.clipsToBounds = true
            self.lblSiren.numberOfLines = 1
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
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
    
    
//MARK: - callPart
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didEnterBackground() {
        print("didEnterBackgroud")
        
        let AfterCallingVC = self.storyboard?.instantiateViewController(identifier: "AfterCallingVC") as! AfterCallingVC
        self.modalPresentationStyle = .fullScreen
        self.present(AfterCallingVC, animated: true, completion: nil)
    }
    
    @IBAction func call(_ sender: UIButton) {
        print("push")
        if let url = NSURL(string: "tel://01041705700"), UIApplication.shared.canOpenURL(url as URL){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

//MARK: - messagePart
    
    
@IBAction func messagePressed(_ sender: UIButton) {
        print("message")
    
    guard MFMessageComposeViewController.canSendText() else {
        print("SMS services are not available")
        return
    }

    
    let composeViewController = MFMessageComposeViewController()
    composeViewController.messageComposeDelegate = self
    composeViewController.recipients = ["112"]
    composeViewController.body = """
    현재위치: \(strLocation)
    내용:
    """
    
    present(composeViewController, animated: true, completion: nil)
}
    
    
}

extension MainViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("cancelled")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("sent message:", controller.body ?? "")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("failed")
            dismiss(animated: true, completion: nil)
        @unknown default:
            print("unkown Error")
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: -LocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            nowLocation = location
            strLocation = String("\(nowLocation!)")
            print(strLocation)
                    }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error)
    }
    
}



