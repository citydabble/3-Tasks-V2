//
//  AddTaskViewController.swift
//  Gate94
//
//  Created by Hayden on 2014-08-16.
//  Copyright (c) 2014 Hayden. All rights reserved.
//

import UIKit

protocol AddTaskViewControllerDelegate {
    func didCancel()
    func didAddTask(task: Task)
}


class AddTaskViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var delegate :AddTaskViewControllerDelegate?
    
    @IBOutlet var taskTitleTextField: UITextField!
    @IBOutlet var taskDescriptionTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func saveTaskButtonPressed(sender: AnyObject!) {
        self.delegate?.didAddTask(self.returnNewTaskObject())
    }
    
    
    func returnNewTaskObject() -> Task {
        var taskObject : Task = Task()
        taskObject.title = self.taskTitleTextField.text
        taskObject.desc = self.taskDescriptionTextField.text
        taskObject.date = self.datePicker.date
        taskObject.isCompleted = false
        return taskObject
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
