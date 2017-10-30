//
//  Timeline+CoreDataProperties.swift
//  GoalsTimelineApp
//
//  Created by Mar Koss on 2017-10-30.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//
//

import Foundation
import CoreData


extension Timeline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timeline> {
        return NSFetchRequest<Timeline>(entityName: "Timeline")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var info: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var startDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var steppingStones: NSSet?

}

// MARK: Generated accessors for steppingStones
extension Timeline {

    @objc(addSteppingStonesObject:)
    @NSManaged public func addToSteppingStones(_ value: SteppingStone)

    @objc(removeSteppingStonesObject:)
    @NSManaged public func removeFromSteppingStones(_ value: SteppingStone)

    @objc(addSteppingStones:)
    @NSManaged public func addToSteppingStones(_ values: NSSet)

    @objc(removeSteppingStones:)
    @NSManaged public func removeFromSteppingStones(_ values: NSSet)

}
