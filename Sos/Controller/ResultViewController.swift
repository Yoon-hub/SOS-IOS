//
//  ResultViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/20.
//

import UIKit
import AVFoundation
import CoreLocation

class ResultViewController: UIViewController {
    
    @IBOutlet var lblLocation: UILabel!
    var sirenSound : AVAudioPlayer!
    var siren :Bool?
    var location : CLLocation?
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblLocation.numberOfLines = 0
        sirenCheck()
        navigationItem.hidesBackButton = true
        
        if let opLocation = location{
            convertToAddressWith(coordinate: opLocation)
        } else{
            UpdateUi(text: "현재 위치정보 업데이트 중")
        }
        
    }
    
    @IBAction func btnHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func sirenCheck() {
        if siren! == true{
            
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print(error)
            }
            
            let url = Bundle.main.url(forResource: "Spaceship Alarm" , withExtension: "mp3")
            sirenSound = try! AVAudioPlayer(contentsOf:  url!) // cd를 넣음
            sirenSound.numberOfLoops = 100
            sirenSound.setVolume(4.0, fadeDuration: 500)
            sirenSound.play() // 재생버튼!
        }
    }

    
    func convertToAddressWith(coordinate: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(coordinate) { (placemarks, error) -> Void in
            if error != nil {
                NSLog("\(error)")
                return
            }
            guard let placemark = placemarks?.first,
                  var addrList = placemark.addressDictionary?["FormattedAddressLines"] as? [String] else {
                      return
                  }
//            addrList.removeLast()
            if let placemark = placemarks?.first{
                if let subThoroughfare = placemark.subThoroughfare {
                    addrList.append(subThoroughfare)
                }
            }
            let address = addrList.joined(separator: " ")
            self.UpdateUi(text: address)
        }
    }
    
    func UpdateUi(text: String){
        DispatchQueue.main.async{
            self.lblLocation.text = text
        }
    }
}

    

