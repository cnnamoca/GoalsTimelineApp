//
//  AllTimelinesViewController.swift
//  GoalsTimelineApp
//
//  Created by Olga on 10/30/17.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit
import CoreData

class AllTimelinesViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var timelineTableView: UITableView!
    
    var managedObjectContext : NSManagedObjectContext? = nil
    var timelineArray : Array<Timeline> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchTimelineData()
        timelineTableView.reloadData()
    }
    
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "timelineCell" , for: indexPath)
        let timeline : Timeline = self.timelineArray[indexPath.row]
        cell.textLabel?.text = timeline.title
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath : IndexPath = timelineTableView.indexPathForSelectedRow {
            let selectedRow = indexPath.row
            let timelineVC : TimelineViewController = segue.destination as! TimelineViewController
            timelineVC.timeline = timelineArray[selectedRow]
        }
    }
    
    //MARK: - Delete Timeline
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
        
        let context : NSManagedObjectContext = persistentContainer.viewContext
        
        let timeline = timelineArray[indexPath.row]
        
        if editingStyle == .delete {
            
            // remove the item from Core Data
            context.delete(timeline)
            appDelegate.saveContext()
            self.fetchTimelineData()

            timelineTableView.reloadData()
        }
    }
    
    // MARK: - Custom Functions
    
    func fetchTimelineData() {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
        
        let context : NSManagedObjectContext = persistentContainer.viewContext
        let request : NSFetchRequest = Timeline.fetchRequest()
        timelineArray = try! context.fetch(request)
        print ("there are \(timelineArray.count) items in the array")
    }
}
