//
//  AddAssignmentViewController.swift
//  HomeworkManagement
//
//  Created by FreshMac on 10/28/17.
//  Copyright © 2017 FreshMac. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var dropDown1: UIDatePicker!
    @IBOutlet weak var dropDown2: UIDatePicker!

    @IBAction func cancelButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButton(_ sender: Any) {
        let newAssignment = Assignment.init(name: nameLabel.text!, start: dropDown1.date, end: dropDown2.date)
        let controllerStack = self.navigationController?.viewControllers
        let parent = controllerStack![(controllerStack?.count)!-2] as! MainViewController
        parent.addAssignment(newAssignment: newAssignment)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
