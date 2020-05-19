//
//  ScoreViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 19/05/2020.
//  Copyright © 2020 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToLevelMenuFromStages(segue: UIStoryboardSegue) {
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
