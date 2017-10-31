//
//  TimelineViewController.swift
//  GoalsTimelineApp
//
//  Created by Carlo Namoca on 2017-10-30.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit
import CoreData

class TimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var timelineArray : Array<Timeline> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        //Hide navigation bar 
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.fetchTimeline()
        
    }
    
    @objc
    func handleLongGesture(gesture: UILongPressGestureRecognizer){
        switch (gesture.state){
        case UIGestureRecognizerState.began:
            guard
                let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
                else { break }
            
            let began = collectionView.beginInteractiveMovementForItem(at: indexPath)
            print("began \(indexPath): \(began)")
            break
            
        case UIGestureRecognizerState.changed:
            print("changed")
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            break
            
        case UIGestureRecognizerState.ended:
            print("ended")
            //update cell name
            //update cell below/above as well
            
            self.collectionView.reloadData()
            collectionView.endInteractiveMovement()
            break
            
        default:
            print("default")
            collectionView.cancelInteractiveMovement()
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "timelineCell", for: indexPath) as! TimelineCollectionViewCell
        cell.titleLabel.text = "\(indexPath.row)"
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //needs to be updated
        return 5
    }
    
    //    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    //        print("can move")
    //        return true
    //    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("move item \(sourceIndexPath) to \(destinationIndexPath)")
        //update datasource
    }
    
    @IBAction func homeButton(_ sender: Any) {
    }
    @IBAction func editButton(_ sender: Any) {
    }
    @IBAction func addButton(_ sender: Any) {
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
