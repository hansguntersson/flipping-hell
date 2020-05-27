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
        
        // TODO: decide what scores and stats are shown
        /*
                Summary of stars won for each type
                Stages completed, Levels completed
                Top ranking users, based on various metrics:
                - most levels won
                - most stars
                - level completed most times
                - score (based on stars)
                - most attempts
                - attempts / won ratio
                
                Should green stars indicate that you're the first person to complete a level?
                Wnat's the highest number for any number of flips?
        
               */
        
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
