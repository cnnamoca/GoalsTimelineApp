import UIKit
import CoreData

class EditSteppingViewController: UIViewController {

    @IBOutlet weak var edtitSteppingStoneTitleView: UITextField!
    @IBOutlet weak var editSteppingStoneNotesView: UITextView!
    @IBOutlet weak var editSteppingStoneDeadline: UIDatePicker!
    var steppingStoneObject : SteppingStone = SteppingStone ()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateFieldsWithExistindData()
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
    
}
