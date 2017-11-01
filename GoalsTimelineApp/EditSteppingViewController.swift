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
    
    @IBAction func saveSteppingStoneChanges(_ sender: UIButton) {

        self.steppingStoneObject.title = edtitSteppingStoneTitleView.text
        self.steppingStoneObject.info = editSteppingStoneNotesView.text
        self.steppingStoneObject.deadline = editSteppingStoneDeadline.date as NSDate
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelEditing(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - View setup
    func populateFieldsWithExistindData() {
        edtitSteppingStoneTitleView.text = steppingStoneObject.title
        editSteppingStoneNotesView.text = steppingStoneObject.info
        editSteppingStoneDeadline.date = steppingStoneObject.deadline! as Date
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
