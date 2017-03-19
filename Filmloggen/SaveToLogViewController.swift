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
    var coreMovie : CoreMovie!
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
        
        if CoreDataHelper.isMovieInList(imdbID: movie.imdbID, listName: CoreDataHelper.filmLogListName) {
            coreMovie = CoreDataHelper.getCoreMovieFromDB(imdbId: movie.imdbID)
            saveButton.setTitle("Spara ändringar", for: .normal)
            datePicker.date = coreMovie.watchDate as! Date
            setUpViewForRating(userRating: Int(coreMovie.userRating))
        }
    }
    
    func setUpViewForRating (userRating: Int) {
        switch userRating {
        case 1:
            rating = 1
            rate1Button.setTitleColor(orangeColor, for: .normal)
            rate2Button.setTitleColor(grayColor, for: .normal)
            rate3Button.setTitleColor(grayColor, for: .normal)
            rate4Button.setTitleColor(grayColor, for: .normal)
            rate5Button.setTitleColor(grayColor, for: .normal)
        case 2:
            rating = 2
            rate1Button.setTitleColor(orangeColor, for: .normal)
            rate2Button.setTitleColor(orangeColor, for: .normal)
            rate3Button.setTitleColor(grayColor, for: .normal)
            rate4Button.setTitleColor(grayColor, for: .normal)
            rate5Button.setTitleColor(grayColor, for: .normal)
        case 3:
            rating = 3
            rate1Button.setTitleColor(orangeColor, for: .normal)
            rate2Button.setTitleColor(orangeColor, for: .normal)
            rate3Button.setTitleColor(orangeColor, for: .normal)
            rate4Button.setTitleColor(grayColor, for: .normal)
            rate5Button.setTitleColor(grayColor, for: .normal)
        case 4:
            rating = 4
            rate1Button.setTitleColor(orangeColor, for: .normal)
            rate2Button.setTitleColor(orangeColor, for: .normal)
            rate3Button.setTitleColor(orangeColor, for: .normal)
            rate4Button.setTitleColor(orangeColor, for: .normal)
            rate5Button.setTitleColor(grayColor, for: .normal)
        default:
            rating = 5
            rate1Button.setTitleColor(orangeColor, for: .normal)
            rate2Button.setTitleColor(orangeColor, for: .normal)
            rate3Button.setTitleColor(orangeColor, for: .normal)
            rate4Button.setTitleColor(orangeColor, for: .normal)
            rate5Button.setTitleColor(orangeColor, for: .normal)
        }
    }

    @IBAction func onRateButtonPressed(_ sender: UIButton) {
        if sender == self.view.viewWithTag(1) {
            setUpViewForRating(userRating: 1)
        } else if sender == self.view.viewWithTag(2) {
            setUpViewForRating(userRating: 2)
        } else if sender == self.view.viewWithTag(3) {
            setUpViewForRating(userRating: 3)
        } else if sender == self.view.viewWithTag(4) {
            setUpViewForRating(userRating: 4)
        } else if sender == self.view.viewWithTag(5) {
            setUpViewForRating(userRating: 5)
        }
    }
    
    @IBAction func onSaveButtonPressed(_ sender: UIButton) {
        if CoreDataHelper.isMovieInList(imdbID: movie.imdbID, listName: CoreDataHelper.filmLogListName) {
            if let year = movie.year {
                coreMovie.year = Int32(year)
            }
            coreMovie.userRating = Int32(rating)
            coreMovie.watchDate = datePicker.date as NSDate
        } else {
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
        }
        CoreDataHelper.saveContext()
        self.navigationController!.popViewController(animated: true)
    }
}
