//
//  NewTimelineViewController.swift
//  GoalsTimelineApp
//
//  Created by Olga on 10/30/17.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit
import CoreData

class NewTimelineViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {
    @IBOutlet weak var newTimelineTitleView: UITextField!
    @IBOutlet weak var newTimelineNotesView: UITextView!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var addNewTimelineButton: UIButton!
    var timelineObject : Timeline = Timeline ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        newTimelineTitleView.delegate = self
        //Don't allow End date to be in the past respective to start date
        startDatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
       //resigns FirstResponder when clicking outside of textview
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // "Add new Timeline" is disabled until user input timeline title
        self.addNewTimelineButton.isEnabled = false
        addNewTimelineButton.alpha = 0.5;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupTextfieldsView()
        self.setupDatePickers()
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
        timelineObject = newTimeline
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let timelineVC : TimelineViewController = segue.destination as! TimelineViewController
        
            timelineVC.timeline = timelineObject
        }
    
    
    // MARK: - Text Fields setup

    //Enables/disables "Add new Timeline" button depending on title text field
    func textFieldShouldEndEditing(_ newTimelineTitleView: UITextField) -> Bool {
        if (newTimelineTitleView.text?.isEmpty)! {
            self.addNewTimelineButton.isEnabled = false
        } else {
            self.addNewTimelineButton.isEnabled = true
            addNewTimelineButton.alpha = 1.0;
        }
        return true
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
    
    // MARK: - Datepickers setup
    
    //Set start daypicker default value to today, don't let select date in the past
    func setupDatePickers() {
        startDatePicker.minimumDate = NSDate() as Date
    }
    
    //Don't let End Date to be earlier then Start date
   @objc func datePickerValueChanged(_ startDatePicker: UIDatePicker) {
        endDatePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 1, to: startDatePicker.date)
    }

}
