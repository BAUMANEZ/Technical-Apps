//
//  ViewController.swift
//  Weekly finder
//
//  Created by Арсений Токарев on 12.07.2020.
//  Copyright © 2020 ATI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var tfDay: UITextField!
    @IBOutlet weak var tfMonth: UITextField!
    @IBOutlet weak var tfYear: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    @IBAction func findDay(_ sender: UIButton) {
        
        guard let day = tfDay.text, let month = tfMonth.text, let year = tfYear.text else {return }
        guard tfDay.text != "", tfMonth.text != "", tfYear.text != ""
        else {
            lblResult.text = "Wrong date. Try Again"
            return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = Int(day)
        dateComponents.year = Int(year)
        dateComponents.month = Int(month)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        guard let DATE = calendar.date(from: dateComponents) else {
            lblResult.text = "Wrong date. Try again"
            return }
        lblResult.text = dateFormatter.string(from: DATE)
    }
    
}

