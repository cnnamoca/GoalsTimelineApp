import UIKit
import CoreData

class TimelineDetailViewController: UIViewController {

    @IBOutlet weak var editTimelineTitleTextField: UITextField!
    @IBOutlet weak var editTimelineNotesTextView: UITextView!
    @IBOutlet weak var timelineStartDatePicker: UIDatePicker!
    @IBOutlet weak var timelineEndDatePicker: UIDatePicker!
    var timelineObject : Timeline = Timeline ()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateFieldsWithTimelineData()
        

    }
    @IBAction func cancelTimelineEditing(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTimelineChanges(_ sender: UIBarButtonItem) {
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let _ : NSPersistentContainer = appDelegate.persistentContainer
                
        self.timelineObject.title = editTimelineTitleTextField.text
        self.timelineObject.info = editTimelineNotesTextView.text
        self.timelineObject.startDate = timelineStartDatePicker.date as NSDate
        self.timelineObject.endDate = timelineEndDatePicker.date as NSDate
        
        appDelegate.saveContext()
        self.dismiss(animated: true, completion: nil)
        }
    
    func populateFieldsWithTimelineData() {
        editTimelineTitleTextField.text = timelineObject.title
        editTimelineNotesTextView.text = timelineObject.info
        timelineStartDatePicker.date = timelineObject.startDate! as Date
        timelineEndDatePicker.date = timelineObject.endDate! as Date
    }
    
}
