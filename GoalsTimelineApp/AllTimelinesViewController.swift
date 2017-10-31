//
//  AllTimelinesViewController.swift
//  GoalsTimelineApp
//
//  Created by Olga on 10/30/17.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit
import CoreData

class AllTimelinesViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext : NSManagedObjectContext? = nil
    var timelineArray : Array<Timeline> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func fetchTimeline() {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
        
        let context : NSManagedObjectContext = persistentContainer.viewContext
        let request : NSFetchRequest = Timeline.fetchRequest()
        timelineArray = try! context.fetch(request)
        print ("there are \(timelineArray.count) items in the array")
        
    }
    
}
