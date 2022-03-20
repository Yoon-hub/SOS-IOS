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
    var sirenSound : AVAudioPlayer!
    var siren :Bool?
    
    @IBOutlet var lblLocation: UILabel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            sirenSound.setVolume(9.0, fadeDuration: 500)
            sirenSound.play() //1재생버튼!
        }
    }
    
    @IBAction func btnHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
