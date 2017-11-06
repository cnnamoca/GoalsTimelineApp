import UIKit
import CoreData

class EditSteppingViewController: UIViewController {

    @IBOutlet weak var edtitSteppingStoneTitleView: UITextField!
    @IBOutlet weak var editSteppingStoneNotesView: UITextView!
    @IBOutlet weak var editSteppingStoneDeadline: UIDatePicker!
    var steppingStoneObject : SteppingStone = SteppingStone ()
    var timelineObject : Timeline = Timeline ()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateFieldsWithExistindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupDatePicker()
    }
    
    @IBAction func saveSteppingStoneChanges(_ sender: UIBarButtonItem) {
        
        self.steppingStoneObject.title = edtitSteppingStoneTitleView.text
        self.steppingStoneObject.info = editSteppingStoneNotesView.text
        self.steppingStoneObject.deadline = editSteppingStoneDeadline.date as NSDate
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelEditing(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View setup
    func populateFieldsWithExistindData() {
        edtitSteppingStoneTitleView.text = steppingStoneObject.title
        editSteppingStoneNotesView.text = steppingStoneObject.info
        editSteppingStoneDeadline.date = steppingStoneObject.deadline! as Date
    }
    
    //Set start daypicker default value to today, don't let select date in the past
    func setupDatePicker() {
        editSteppingStoneDeadline.minimumDate = NSDate() as Date
        editSteppingStoneDeadline.maximumDate = (timelineObject.endDate! as Date)
    }
    
}
