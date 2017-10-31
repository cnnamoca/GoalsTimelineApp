//
//  NewTimelineViewController.swift
//  GoalsTimelineApp
//
//  Created by Olga on 10/30/17.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit
import CoreData

class NewTimelineViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var newTimelineTitleView: UITextField!
    @IBOutlet weak var newTimelineNotesView: UITextView!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextfieldsView()

    }
  
    @IBAction func addNewTimeline(_ sender: Any) {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
        
        let newTimeline : Timeline = Timeline(context: persistentContainer.viewContext)
        newTimeline.title = newTimelineTitleView.text
        newTimeline.info = newTimelineNotesView.text
        newTimeline.startDate = startDatePicker.date as NSDate
        newTimeline.endDate = endDatePicker.date as NSDate
        newTimeline.isCompleted = false
        
        appDelegate.saveContext()
        
        
        
    }

    //Set up "fake" placeholder in Note textView
    func setupTextfieldsView() {
        newTimelineNotesView.delegate = self
        newTimelineNotesView.textColor = UIColor.lightGray
        newTimelineNotesView.text = "Notes"
    }
    
    //Remove "fake" placeholder when uset taps on textview
    func textViewDidBeginEditing(_ newTimelineNotesView: UITextView) {
        if newTimelineNotesView.text == "Notes"
        {
            newTimelineNotesView.text = ""
            newTimelineNotesView.textColor = UIColor.black
        }
        newTimelineNotesView.becomeFirstResponder()
    }
    
    //Show "fake" placeholder if user entered nothing
    func textViewDidEndEditing(_ newTimelineNotesView: UITextView)
    {
        if (newTimelineNotesView.text == "")
        {
            newTimelineNotesView.text = "Notes"
            newTimelineNotesView.textColor = .lightGray
        }
        newTimelineNotesView.resignFirstResponder()
    }
    

}
