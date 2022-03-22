//
//  ResultViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/20.
//

import UIKit
import AVFoundation
import CoreLocation

class ResultViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var lblLocation: UILabel!
    var sirenSound : AVAudioPlayer!
    var siren :Bool?
    var locationManager:CLLocationManager!
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblLocation.numberOfLines = 0
        
        locationCheck()
        sirenCheck()
        
    }
    
    @IBAction func btnHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
    
    func locationCheck() {

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
        let location = CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
        
        convertToAddressWith(coordinate: location)
        
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
            addrList.removeLast()
            let address = addrList.joined(separator: " ")
            self.lblLocation.text = address
        }
    }


    

}
