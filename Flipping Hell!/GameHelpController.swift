//
//  GameHelpViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 19/05/2020.
//  Copyright © 2020 Hans Guntersson Ltd. All rights reserved.
//

import UIKit
import AVFoundation
    

// ********************************** CLASS DEFINITION ********************************** //

class GameHelpViewController: UIViewController {
    
    // ********************************** SOUNDS ********************************** //

    let swooshsoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "swoosh.mp3", ofType: nil)!)
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: self.swooshsoundurl)
                audioPlayer?.volume = 1
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file")
            }
        }
    }
}
