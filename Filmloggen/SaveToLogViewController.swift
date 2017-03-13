//
//  SaveToLogViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-13.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit

class SaveToLogViewController: UIViewController {
    
    @IBOutlet weak var rate1Button: UIButton!
    @IBOutlet weak var rate2Button: UIButton!
    @IBOutlet weak var rate3Button: UIButton!
    @IBOutlet weak var rate4Button: UIButton!
    @IBOutlet weak var rate5Button: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    let orangeColor = UIColor(red: 255/255, green: 102/255, blue: 0, alpha: 1)
    let grayColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)

    var rating = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onRateButtonPressed(_ sender: UIButton) {
        if sender == self.view.viewWithTag(1) {
            rating = 1
            rate1Button.setTitleColor(orangeColor, for: .normal)
            rate2Button.titleLabel?.textColor = grayColor
            rate3Button.titleLabel?.textColor = grayColor
            rate4Button.titleLabel?.textColor = grayColor
            rate5Button.titleLabel?.textColor = grayColor
        } else if sender == self.view.viewWithTag(2) {
            rating = 2
            rate1Button.titleLabel?.textColor = orangeColor
            rate2Button.setTitleColor(orangeColor, for: .normal)
            rate3Button.titleLabel?.textColor = grayColor
            rate4Button.titleLabel?.textColor = grayColor
            rate5Button.titleLabel?.textColor = grayColor
        } else if sender == self.view.viewWithTag(3) {
            rating = 3
            rate1Button.titleLabel?.textColor = orangeColor
            rate2Button.titleLabel?.textColor = orangeColor
            rate3Button.setTitleColor(orangeColor, for: .normal)
            rate4Button.titleLabel?.textColor = grayColor
            rate5Button.titleLabel?.textColor = grayColor
        } else if sender == self.view.viewWithTag(4) {
            rating = 4
            rate1Button.titleLabel?.textColor = orangeColor
            rate2Button.titleLabel?.textColor = orangeColor
            rate3Button.titleLabel?.textColor = orangeColor
            rate4Button.setTitleColor(orangeColor, for: .normal)
            rate5Button.titleLabel?.textColor = grayColor
        } else if sender == self.view.viewWithTag(5) {
            rating = 5
            rate1Button.titleLabel?.textColor = orangeColor
            rate2Button.titleLabel?.textColor = orangeColor
            rate3Button.titleLabel?.textColor = orangeColor
            rate4Button.titleLabel?.textColor = orangeColor
            rate5Button.setTitleColor(orangeColor, for: .normal)
        }
        
        print(rating)
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
