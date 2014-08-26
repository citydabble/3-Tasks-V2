//
//  TaskDetailsViewController.swift
//  Gate94
//
//  Created by Hayden on 2014-08-26.
//  Copyright (c) 2014 Hayden. All rights reserved.
//

import UIKit

class TaskDetailsViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var taskTitle: UILabel!
    
    @IBOutlet var taskDescription: UILabel!
    
    @IBOutlet var taskDate: UILabel!
    
    

}