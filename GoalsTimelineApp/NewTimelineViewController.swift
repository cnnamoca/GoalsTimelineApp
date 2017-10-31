//
//  NewTimelineViewController.swift
//  GoalsTimelineApp
//
//  Created by Olga on 10/30/17.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit

class NewTimelineViewController: UIViewController {
    @IBOutlet weak var newTimelineTitleView: UITextField!
    
    @IBOutlet weak var newTimelineNotesView: UITextView!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextfieldsView()

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func addNewTimeline(_ sender: Any) {
    }

    //Set up "fake" placeholder in Note textView
    func setupTextfieldsView() {
        newTimelineNotesView.textColor = UIColor.lightGray
        newTimelineNotesView.text = "Notes"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
