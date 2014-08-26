//
//  Task.swift
//  Gate94
//
//  Created by Hayden on 2014-08-18.
//  Copyright (c) 2014 Hayden. All rights reserved.
//

import Foundation

class Task {


    var title :String
    var desc :String!
    var date : NSDate!
    var isCompleted :Bool
    
    init() {
        self.title = ""
        self.isCompleted = false
    }
    
    
    init(fromDictionary data: NSDictionary) {
        self.title = data[TASK_TITLE] as String
        self.desc = data[TASK_DESCRIPTION] as String
        self.date = data[TASK_DATE] as NSDate
        self.isCompleted = data[TASK_COMPLETION] as Bool
    }
    
}