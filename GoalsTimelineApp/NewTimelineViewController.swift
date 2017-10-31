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

    }
  
    @IBAction func addNewTimeline(_ sender: Any) {
    }

    //Set up "fake" placeholder in Note textView
    func setupTextfieldsView() {
        newTimelineNotesView.textColor = UIColor.lightGray
        newTimelineNotesView.text = "Notes"
    }
    
    

}
