//
//  ViewController.swift
//  TConverter
//
//  Created by Арсений Токарев on 13.07.2020.
//  Copyright © 2020 ATI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var farhenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.maximumValue = 50
            slider.minimumValue = -70
        }
    }
    

    @IBAction func sliderChanged(_ sender: UISlider) {
        celciusLabel.text = "\(Int(round(slider.value)))º"
        let farhenheitT = Int(round(slider.value) * 9 / 5 + 32)
        farhenheitLabel.text = "\(farhenheitT)º"
        
    }
    
}

