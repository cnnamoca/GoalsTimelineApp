import UIKit

class TimelineDetailViewController: UIViewController {

    @IBOutlet weak var editTimelineTitleTextField: UITextField!
    @IBOutlet weak var editTimelineNotesTextView: UITextView!
    @IBOutlet weak var timelineStartDatePicker: UIDatePicker!
    @IBOutlet weak var timelineEndDatePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    @IBAction func cancelTimelineEditing(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func saveTimelineChanges(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
        }
    
}
