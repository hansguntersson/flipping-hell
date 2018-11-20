//
//  WinScreenController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 12/11/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class WinScreenController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func replayLevel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backToLevelView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
