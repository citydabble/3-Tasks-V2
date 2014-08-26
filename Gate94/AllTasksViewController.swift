//
//  AllTasksViewController.swift
//  Gate94
//
//  Created by Hayden on 2014-08-16.
//  Copyright (c) 2014 Hayden. All rights reserved.
//

import UIKit

class AllTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,AddTaskViewControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        var tasksAsPropertyLists : NSArray = NSUserDefaults.standardUserDefaults().arrayForKey(TASK_OBJECTS_KEY)!
        
        for dictionary in tasksAsPropertyLists {
            var taskObject :Task  = taskObjectForDictionary(dictionary as NSDictionary)
            tasks.append(taskObject)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Tasks Object
    
    var tasks : [Task] = []
    
    //MARK: UITableViewDataSourc = []e Methods
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cellIdentifier = "Cell"
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        //Configure cell:
        
        var task: Task = tasks[indexPath.row] as Task
        cell.textLabel.text = task.title
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat="yyyy-MM-dd"
        var stringFromDate :NSString = formatter.stringFromDate(task.date)
        cell.detailTextLabel.text = stringFromDate
        
        if (task.isCompleted) {
            cell.backgroundColor = UIColor.greenColor()
        }
        return cell
    }
    
    
    //MARK: UITableView Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        var task: Task = tasks[indexPath.row] as Task
        updateCompletionOfTask(task, indexPath: indexPath)
    }
    
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath: NSIndexPath!) -> Bool{
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        var newTaskObjectData : [NSDictionary] = []
        if (commitEditingStyle == UITableViewCellEditingStyle.Delete) {
            tasks.removeAtIndex(indexPath.row)
            for task : Task in tasks {
                newTaskObjectData.append(taskObjectAsPropertyList(task))
            }
            
            NSUserDefaults.standardUserDefaults().setObject(newTaskObjectData, forKey: TASK_OBJECTS_KEY)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            tableView.deleteRowsAtIndexPaths([indexPath.row], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    
    
    //MARK: Helper methods
    
    
    func taskObjectAsPropertyList(task:Task) -> NSDictionary {
        var dictionary :NSDictionary = [TASK_TITLE:task.title, TASK_DESCRIPTION:task.desc, TASK_DATE:task.date, TASK_COMPLETION:task.isCompleted]
        return  dictionary
    }
    
    func taskObjectForDictionary(dictionary:NSDictionary) -> Task {
        var task :Task = Task(fromDictionary: dictionary)
        return task
    }
    
    
    func updateCompletionOfTask(task:Task, indexPath:NSIndexPath) {
        
        var taskObjectsAsPropertyLists : [AnyObject] = NSUserDefaults.standardUserDefaults().arrayForKey(TASK_OBJECTS_KEY)!
        
        taskObjectsAsPropertyLists.removeAtIndex(indexPath.row)
        if (task.isCompleted) {
            task.isCompleted = false
        }
        
        task.isCompleted = true
        
        taskObjectsAsPropertyLists.insert(self.taskObjectAsPropertyList(task), atIndex: (indexPath.row))
        
        NSUserDefaults.standardUserDefaults().setObject(taskObjectsAsPropertyLists,forKey: TASK_OBJECTS_KEY)
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
    }
    
    
    //MARK: AddTaskViewControllerDelegate
    
    func didAddTask(task: Task) {
        self.tasks.append(task)
        
        NSLog ("%@", task.title);
        
        var taskObjectsAsPropertyLists : [AnyObject] = NSUserDefaults.standardUserDefaults().arrayForKey(TASK_OBJECTS_KEY)!
        
        taskObjectsAsPropertyLists.append(self.taskObjectAsPropertyList(task))
        
        NSUserDefaults.standardUserDefaults().setObject(taskObjectsAsPropertyLists,forKey: TASK_OBJECTS_KEY)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.dismissViewControllerAnimated(true, completion:nil)
        
        
        //Tell Table View to Reload Info
        
        self.tableView.reloadData()
    }
    
    func didCancel() {
        self.dismissViewControllerAnimated(true, completion:nil)
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
