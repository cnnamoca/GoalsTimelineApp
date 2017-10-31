

import Foundation
import CoreData


extension SteppingStone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SteppingStone> {
        return NSFetchRequest<SteppingStone>(entityName: "SteppingStone")
    }

    @NSManaged public var deadline: NSDate?
    @NSManaged public var info: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var timelines: Timeline?

}
