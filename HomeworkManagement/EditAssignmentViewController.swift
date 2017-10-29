//
//  EditAssignmentViewController.swift
//  HomeworkManagement
//
//  Created by Sathvik Kadaveru on 10/28/17.
//  Copyright © 2017 FreshMac. All rights reserved.
//

import UIKit

class EditAssignmentViewController: UIViewController {
    
    var assignment: Assignment?
    var assignmentIndex: Int?
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = assignment?.name
        startPicker.date = (assignment?.start)!
        endPicker.date = (assignment?.end)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func discardEditsPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
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
