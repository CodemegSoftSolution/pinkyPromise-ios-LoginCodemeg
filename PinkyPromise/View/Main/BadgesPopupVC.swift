//
//  BadgesPopupVC.swift
//  PinkyPromise
//
//  Created by AkshCom on 28/01/22.
//  Copyright © 2022 iMac. All rights reserved.
//

import UIKit
import AVFoundation

class BadgesPopupVC: UIViewController {

    @IBOutlet weak var popupBackView: View!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var animationImgView: UIImageView!
    
    @IBOutlet weak var potliImgView: UIImageView!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    
    func configUI()  {
        
    }
    
    func setupDetails(_ badgeImg: String,_ title : String,_ bottomDesc: String?,_ isCoin: Bool) {
        delay(0.0) {
            self.titleLbl.text = title
            self.bottomLbl.text = bottomDesc
            
            if isCoin {
                do {
                    self.playSound()
                    let gif = try UIImage(gifName: "coin_ani.gif")
                    self.imgView.setGifImage(gif, loopCount: -1)
                } catch {
                    print(error)
                }
            }
            else{
                self.imgView.image = UIImage.init(named: badgeImg)
            }            
        }
    }
    
    func viewHideFromBackView(_ isCoin: Bool) {
        if isCoin {
            do {
                popupBackView.isHidden = true
                let gif = try UIImage(gifName: "animation_300.gif")
                self.potliImgView.setGifImage(gif, loopCount: -1)
            } catch  {
                
            }
        }
        else{
            do {
                popupBackView.isHidden = true
                let gif = try UIImage(gifName: "congratulation.gif")
                self.animationImgView.setGifImage(gif, loopCount: -1)
            } catch  {
                
            }
        }
    }
    
    @IBAction func clickToCancel(_ sender: Any) {
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "chime_bell_ding", withExtension: "wav") else {
            print("url not found")
            return
        }

        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            /// change fileTypeHint according to the type of your audio file (you can omit this)
            player?.numberOfLoops = 0
            player = try AVAudioPlayer(contentsOf: url)
            player!.play()
            
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
}
