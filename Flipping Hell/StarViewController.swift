//
//  StarViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 11/11/2021.
//  Copyright © 2021 Hans Guntersson Ltd. All rights reserved.
//
//

import UIKit
import AVFoundation

// ********************************** CLASS DEFINITION ********************************** //

class StarViewController: UIViewController {
    
    //weak var game: FlippingHell?
    
    var StarsInput: String = "☆ ☆ ☆"
    var FlipsInput: String = "0 of 1"
    var SequenceInput: String = "122221"
    
    // ********************************** SOUNDS ********************************** //

    let swooshsoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "swoosh.mp3", ofType: nil)!)
    
    // ********************************** OUTLETS ********************************** //
    
    @IBOutlet weak var Stars: UILabel!
    @IBOutlet weak var Flips: UILabel!
    @IBOutlet weak var Sequence: UILabel!
    
    // ********************************** LOAD FUNCTION ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        Stars.text = StarsInput
        Flips.text = FlipsInput
        Sequence.text = SequenceInput
    }
    
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
