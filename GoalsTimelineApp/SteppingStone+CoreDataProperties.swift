//
//  SteppingStone+CoreDataProperties.swift
//  GoalsTimelineApp
//
//  Created by Mar Koss on 2017-10-30.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//
//

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
