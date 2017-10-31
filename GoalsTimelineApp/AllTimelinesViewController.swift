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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    var managedObjectContext : NSManagedObjectContext? = nil
    var timelineArray : Array<Timeline> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchTimelineData()
    }
    
    func fetchTimelineData() {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
        
        let context : NSManagedObjectContext = persistentContainer.viewContext
        let request : NSFetchRequest = Timeline.fetchRequest()
        timelineArray = try! context.fetch(request)
        print ("there are \(timelineArray.count) items in the array")
        
    }
    
}
