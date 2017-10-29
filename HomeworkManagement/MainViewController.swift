//
//  MainViewController.swift
//  HomeworkManagement
//
//  Created by FreshMac on 10/28/17.
//  Copyright © 2017 FreshMac. All rights reserved.
//

import UIKit
   
class Assignment: NSObject, NSCoding {
    
    var name: String = ""
    var start: Date = Date.init(timeIntervalSinceNow: 0)
    var end: Date = Date.init(timeIntervalSinceNow: 0)
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(start, forKey: "start")
        aCoder.encode(end, forKey: "end")
    }
    
    init(name: String, start: Date, end: Date) {
        self.name = name
        self.start = start
        self.end = end
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let nameObj = aDecoder.decodeObject(forKey: "name") as? String {
            name = nameObj
        }
        if let startObj = aDecoder.decodeObject(forKey: "start") as? Date {
            start = startObj
        }
        if let endObj = aDecoder.decodeObject(forKey: "end") as? Date {
            end = endObj
        }
    }
    
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var assignments: [Assignment]!
    var dateFormatter: DateFormatter!

    @IBOutlet weak var assignmentTable: UITableView!
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("Data").path
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view, typically from a nib.
        
        dateFormatter = DateFormatter()
        assignments = []
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        /*assignments.append(Assignment.init(name: "Assignment 1",
                                           start: dateFormatter.date(from: "2017/10/02")!,
                                           end: dateFormatter.date(from:"2017/12/31")!))
        assignments.append(Assignment.init(name: "Assignment 2",
                                           start: dateFormatter.date(from: "2017/09/02")!,
                                           end: dateFormatter.date(from:"2017/12/01")!))*/
        assignments = loadAssignments() ?? []
        
        assignmentTable.delegate = self
        assignmentTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath) as! AssignmentCell
        let assignment = assignments[indexPath.row]
        
        cell.nameLabel.text = assignment.name
        cell.startLabel.text = dateFormatter.string(from: assignment.start)
        cell.endLabel.text = dateFormatter.string(from: assignment.end)
        
        let startUnix = assignment.start.timeIntervalSince1970
        let nowUnix = NSDate().timeIntervalSince1970
        let endUnix = assignment.end.timeIntervalSince1970
        
        let totalTime = endUnix - startUnix
        let elapsedtime = nowUnix - startUnix
        var progress = Float(elapsedtime) / Float(totalTime)
        progress = max(min(1, progress), 0)
        
        cell.progressBar.progress = progress
        cell.percentLabel.text = String.init(format: "%3.1f", progress * 100) + "%"
        
        /*print(startUnix)
        print(nowUnix)
        print(endUnix)*/
        
        
        
        return cell
    }
    
    func saveAssignments() {
        let _ = NSKeyedArchiver.archiveRootObject(assignments, toFile: filePath)
        assignments = loadAssignments()
        assignmentTable.reloadData()
    }
    
    func loadAssignments() -> [Assignment]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Assignment]
    }
    
    public func updateAssignment(index: Int, updatedAssignment: Assignment) {
        assignments[index] = updatedAssignment
        saveAssignments()
    }
    
    public func addAssignment(newAssignment: Assignment) {
        assignments.append(newAssignment)
        saveAssignments()
    }
    
    public func deleteAssignment(index: Int) {
        assignments.remove(at: index)
        saveAssignments()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let destination = segue.destination as! EditAssignmentViewController
            let selectedCell = (sender as! UIButton).superview?.superview?.superview?.superview as! AssignmentCell
            let index = assignmentTable.indexPath(for: selectedCell)!.row
            destination.assignment = assignments[index]
            destination.assignmentIndex = index
        }
    }


}


