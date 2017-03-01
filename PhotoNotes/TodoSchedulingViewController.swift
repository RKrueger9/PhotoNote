//
//  TodoSchedulingViewController.swift
//  PhotoNotes
//
//  Created by rkalvani on 2/23/17.
//  Copyright © 2017 rkalvani. All rights reserved.
//

import UIKit

class TodoSchedulingViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        let todoItem = TodoItem(deadline: deadlinePicker.date, title: titleField.text!, UUID: UUID().uuidString)
        TodoList.sharedInstance.addItem(todoItem) // schedule a local notification to persist this item
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
