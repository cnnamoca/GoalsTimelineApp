//
//  AddSteppingStoneViewController.swift
//  GoalsTimelineApp
//
//  Created by Carlo Namoca on 2017-10-31.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit

class AddSteppingStoneViewController: UIViewController {

    @IBOutlet weak var steppingStoneTitle: UITextField!
    @IBOutlet weak var steppingStoneNotes: UITextView!
    @IBOutlet weak var steppingStoneDueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var addNewSteppingStone: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
