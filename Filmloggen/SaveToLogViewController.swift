//
//  SaveToLogViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-13.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit
import CoreData

class SaveToLogViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rate1Button: UIButton!
    @IBOutlet weak var rate2Button: UIButton!
    @IBOutlet weak var rate3Button: UIButton!
    @IBOutlet weak var rate4Button: UIButton!
    @IBOutlet weak var rate5Button: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    let orangeColor = UIColor(red: 255/255, green: 102/255, blue: 0, alpha: 1)
    let grayColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    var movie: Movie!
    var rating = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = movie.title {
            if let year = movie.year {
                titleLabel.text = "\(title) (\(year))"
            } else {
                titleLabel.text = "\(title))"
            }
        } else {
            titleLabel.text = "-"
        }
        
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
    }
    
    
    @IBAction func onSaveButtonPressed(_ sender: UIButton) {
        var coreMovie : CoreMovie!
        
        if CoreDataHelper.doCoreMovieExist(imdbId: movie.imdbID) {
            coreMovie = CoreDataHelper.getCoreMovieFromDB(imdbId: movie.imdbID)
        } else {
            coreMovie = CoreDataHelper.createCoreMovie(imdbID: movie.imdbID, title: movie.title!)
        }
        
        if let year = movie.year {
            coreMovie.year = Int32(year)
        }
        coreMovie.userRating = Int32(rating)
        coreMovie.watchDate = datePicker.date as NSDate
        
        
        let filmlog = CoreDataHelper.getListFromDB(listName: CoreDataHelper.filmLogListName)
        
        filmlog?.addToMovies(coreMovie)
        CoreDataHelper.saveContext()
        self.navigationController!.popViewController(animated: true)
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
