//
//  CellImageManager.swift
//  GoalsTimelineApp
//
//  Created by Mar Koss on 2017-11-03.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

import UIKit

class CellImageManager: NSObject {
    
    var image : UIImage! = nil
    var dateString : String! = nil
    var todayString : String! = nil
    var step : SteppingStone! = nil
//    var todaysDate = NSCalendar.current.date(byAdding: .day, value: 5, to: NSDate() as Date, wrappingComponents: false)! as NSDate
    var todaysDate = NSDate()

    
    init(dateString : String, todayString : String) {
        super.init()
        self.dateString = dateString
        self.todayString = todayString
    }
    
    func selectStepStoneImage() -> UIImage {
        let todaysDate = NSDate()
        if dateString == todayString && step.isCompleted == true {
            image = UIImage(named: "TodayCompletedCell")
        }
        else if dateString != todayString && step.isCompleted == true {
            image = UIImage(named: "completedCell")
        }
        else if dateString == todayString && step.isCompleted == false {
            image = UIImage(named: "TodayCollectCell")
        }
        else if ((todaysDate.timeIntervalSince1970) > (step.deadline?.timeIntervalSince1970)!) && step.isCompleted == false {
            image = UIImage(named: "UnfinishedCell")
        }
        else if dateString != todayString && step.isCompleted == false {
            image = UIImage(named: "CustomCell")
        }
        
        return image
    }
    
    func selectBlankCellImage() -> UIImage {
        if dateString == todayString {
            image = UIImage(named: "TodayEmptyCell")
        }
        else {
            image = UIImage(named: "EmptyCell")
        }
        return image
    }
    
}
