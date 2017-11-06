

import UIKit
import CoreData

class TimelineViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var timelineTitleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var timelineArray : Array<Timeline> = Array()
    var steppingStoneArray : Array<SteppingStone> = Array()
    var timeline : Timeline = Timeline ()
    var stepIndexDict : Dictionary <Int , SteppingStone> = [Int : SteppingStone]()
    var tempStep : SteppingStone? = nil
    var tempIndex : IndexPath? = nil
    var todaysDate:NSDate = NSDate()
    let dateFormatter : DateFormatter = DateFormatter()
    

    @IBAction func homeButton(_ sender: Any) {
    }
    @IBAction func editButton(_ sender: Any) {
    }
    @IBAction func addButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        fetchCoreData()
        collectionView.reloadData()
        updateTimelinetitle()
    }
    

    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var steppingArray : Array<SteppingStone> = (timeline.steppingStones)?.allObjects as! Array<SteppingStone>
        steppingArray = steppingArray.sorted { $0.deadline?.compare($1.deadline! as Date) == .orderedAscending }
        var cell : UICollectionViewCell = UICollectionViewCell()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        todaysDate = NSCalendar.current.date(byAdding: .day, value: 5, to: NSDate() as Date, wrappingComponents: false)! as NSDate
        let indexPathDate = NSDate(timeInterval: (TimeInterval(indexPath.row * 86400)), since:timeline.startDate! as Date )
        let dateString : String = dateFormatter.string(from: indexPathDate as Date)
        let todayString : String = dateFormatter.string(from: todaysDate as Date)
        
        
        let cellImageManager : CellImageManager = CellImageManager(dateString: dateString, todayString: todayString)
        

        let emptyCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as! EmptyCollectionViewCell
        emptyCell.dateLabel.text = dateString
        emptyCell.imageView.image = cellImageManager.selectBlankCellImage()

        

        
        cell = emptyCell
        
        if steppingArray.count > 0 {
            for step : SteppingStone in steppingArray{
                cellImageManager.step = step
                let stepDateString : String = dateFormatter.string(from: step.deadline! as Date)
                if stepDateString == dateString {
                    
                    let stepStoneCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "timelineCell", for: indexPath) as! TimelineCollectionViewCell
                    let myString : String = dateFormatter.string(from: step.deadline! as Date)
                    stepStoneCell.dateLabel.text = "\(myString)"
                    stepStoneCell.titleLabel.text = step.title
                    stepStoneCell.imageView.image = cellImageManager.selectStepStoneImage()

                    stepIndexDict[indexPath.row] = step
                    cell = stepStoneCell
                }
            }
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let dateDifference : TimeInterval = (timeline.endDate?.timeIntervalSince(timeline.startDate! as Date))!
        let intDate = Int(dateDifference)/86400
        
        return intDate
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath) as! FooterCollectionReusableView
        
        return footerView
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    

    // MARK: Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAddSteppingStone" {
            let addSteppingStoneVC : AddSteppingStoneViewController = segue.destination as! AddSteppingStoneViewController
            addSteppingStoneVC.timelineObject = timeline
        }
        
        if segue.identifier == "tapAddStep" {
            let date = sender as! Date
            let tapAddStepVC : AddSteppingStoneViewController = segue.destination as! AddSteppingStoneViewController
            tapAddStepVC.timelineObject = timeline
            tapAddStepVC.initialDate = date
        }
        
        if segue.identifier == "toEditSteppingStone" {
            let editSteppingStoneVC: EditSteppingViewController = segue.destination as! EditSteppingViewController
            
            let steppingStone : SteppingStone = sender as! SteppingStone
            editSteppingStoneVC.steppingStoneObject = steppingStone
            editSteppingStoneVC.timelineObject = timeline
        }
        if segue.identifier == "toDetailView" {
            let timelineDetailVC : TimelineDetailViewController = segue.destination as! TimelineDetailViewController
            
            timelineDetailVC.timelineObject = timeline
            
        }
        
    }
    
    //MARK: GESTURE RECOGNIZERS methods
    
    @objc
    func handleEditStepGesture(gesture: UITapGestureRecognizer) {
        guard
            let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
            else {return}
        if collectionView.cellForItem(at: indexPath) is TimelineCollectionViewCell {
            let indexPathDate = NSDate(timeInterval: (TimeInterval(indexPath.row * 86400)), since:timeline.startDate! as Date )
            let dateString : String = dateFormatter.string(from: indexPathDate as Date)
            
            let steppingArray : Array<SteppingStone> = (timeline.steppingStones)?.allObjects as! Array<SteppingStone>
            for step : SteppingStone in steppingArray{
                let stepDateString : String = dateFormatter.string(from: step.deadline! as Date)
                if stepDateString == dateString {
                    performSegue(withIdentifier: "toEditSteppingStone", sender: step)
                }
            }
        }
    }
    
    
    @objc
    func handleAddStepGesture(gesture: UITapGestureRecognizer) {
        guard
            let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
            else {return}
        if collectionView.cellForItem(at: indexPath) is EmptyCollectionViewCell {
            let indexPathDate = Date.init(timeInterval: (TimeInterval(indexPath.row * 86400)), since:timeline.startDate! as Date)
            performSegue(withIdentifier: "tapAddStep", sender: indexPathDate)
        }
    }
    
    @objc
    func handleDeleteGesture(gesture: UITapGestureRecognizer) {
        guard
            let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
            else {return}
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        tempStep = stepIndexDict[indexPath.row]!
        
        
        if collectionView.cellForItem(at: indexPath) is TimelineCollectionViewCell {
            
            let alert = UIAlertController(title: "This Stepping Stone will be deleted from Timeline", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete Stepping Stone", style: .destructive) { (action) in
                context.delete(self.tempStep!)
                self.tempStep = nil
                self.collectionView.reloadData()
            }
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @objc
    func handleSwipeRight(gesture: UISwipeGestureRecognizer){
        guard
            let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
            else {return}
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let _ : NSPersistentContainer = appDelegate.persistentContainer
        tempStep = nil
        
        if collectionView.cellForItem(at: indexPath) is TimelineCollectionViewCell {
            let cell : TimelineCollectionViewCell = (self.collectionView.cellForItem(at: indexPath) as? TimelineCollectionViewCell)!
            tempStep = stepIndexDict[indexPath.row]!
            
            if tempStep!.isCompleted == false {
                cell.imageView.image = UIImage(named: "completedCell")
                tempStep!.setValue(true, forKey: "isCompleted")
                
            }
            else {
                cell.imageView.image = UIImage(named: "CustomCell")
                tempStep!.setValue(false, forKey: "isCompleted")
            }
            
            appDelegate.saveContext()
            tempStep = nil
            fetchCoreData()

            collectionView.reloadData()
            
        }
    }
    
    @objc
    func handleLongGesture(gesture: UILongPressGestureRecognizer){
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        switch (gesture.state){
        case UIGestureRecognizerState.began:
            guard
                let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
                else { break }
            
            if self.collectionView.cellForItem(at: indexPath) is EmptyCollectionViewCell{
                collectionView.cancelInteractiveMovement()
                break
            }
            tempStep = stepIndexDict[indexPath.row]!
            tempIndex = indexPath
            
            collectionView.beginInteractiveMovementForItem(at: indexPath)

            break
            
        case UIGestureRecognizerState.changed:
            
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
            if indexPath != nil {
            }
        

            break
            
        case UIGestureRecognizerState.ended:
            var indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
            
            
            if indexPath != nil{
                let indexPathDate = NSDate(timeInterval: (TimeInterval((indexPath?.row)! * 86400)), since:timeline.startDate! as Date ) as NSDate
                if let tempStep = tempStep {
                    if self.collectionView.cellForItem(at: indexPath!) is EmptyCollectionViewCell {
                        tempStep.setValue(indexPathDate, forKey:"deadline" )
                        appDelegate.saveContext()
                        fetchCoreData()
                        collectionView.endInteractiveMovement()
                        collectionView.reloadData()
                    }
                    else {
                        collectionView.cancelInteractiveMovement()
                    }

                }
            }
            else if indexPath == nil {
                collectionView.cancelInteractiveMovement()
            }
            
            tempStep = nil
            tempIndex = nil
            collectionView.endInteractiveMovement()
            break
            
        default:
            collectionView.cancelInteractiveMovement()
            break
        }
    }
    
    // CUSTOM FUNCTIONS
    
    fileprivate func createGestures() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
        timelineTitleLabel.text = timeline.title
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.collectionView.addGestureRecognizer(swipeRight)
        
        let deleteGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleDeleteGesture(gesture:)))
        deleteGesture.direction = UISwipeGestureRecognizerDirection.left
        collectionView.addGestureRecognizer(deleteGesture)
        
        
        let addStepGesture = UITapGestureRecognizer(target: self, action: #selector(handleAddStepGesture(gesture:)))
        addStepGesture.numberOfTapsRequired = 2
        collectionView.addGestureRecognizer(addStepGesture)
        
        let editStepGesture = UITapGestureRecognizer(target: self, action: #selector(handleEditStepGesture(gesture:)))
        collectionView.addGestureRecognizer(editStepGesture)
    }
    
    func fetchCoreData() {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer : NSPersistentContainer = appDelegate.persistentContainer
        
        let context : NSManagedObjectContext = persistentContainer.viewContext
        let requestTimelines : NSFetchRequest = Timeline.fetchRequest()
        timelineArray = try! context.fetch(requestTimelines)
        let requestSteppingStones : NSFetchRequest = SteppingStone.fetchRequest()
        steppingStoneArray = try! context.fetch(requestSteppingStones)
    }
    
    func updateTimelinetitle() {
        self.timelineTitleLabel.text = timeline.title
    }
    

    
}
