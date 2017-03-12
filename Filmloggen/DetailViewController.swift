//
//  DetailViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-08.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runningTimeLable: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actor1Label: UILabel!
    @IBOutlet weak var actor2Label: UILabel!
    @IBOutlet weak var actor3Label: UILabel!
    @IBOutlet weak var actor4Label: UILabel!
    @IBOutlet weak var plotTextView: UITextView!
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        if let year = movie.year {
            titleLabel.text = "\(movie.title) (\(year))"
        } else {
            titleLabel.text = "\(movie.title))"
        }
 
        if let runningTime = movie.runningTime {
            runningTimeLable.text = "\(runningTime) minuter"
        } else {
            runningTimeLable.text = "? minuter"
        }
        
        if let genre = movie.genre {
            genreLabel.text = genre
        } else {
            genreLabel.text = " "
        }
        
        if let imdbRating = movie.imdbRating {
            imdbRatingLabel.text = "IMDB: \(imdbRating)"
        } else {
            imdbRatingLabel.text = "IMDB: "
        }
        
        if let director = movie.director {
            directorLabel.text = "Regi: \(director)"
        } else {
            directorLabel.text = "Regi: "
        }
        
        if let actors = movie.actors {
            if actors.count > 0 {
                actor1Label.text = actors[0]
            } else {
                actor1Label.text = " "
            }
            if actors.count > 1 {
                actor2Label.text = actors[1]
            } else {
                actor2Label.text = " "
            }
            if actors.count > 2 {
                actor3Label.text = actors[2]
            } else {
                actor3Label.text = " "
            }
            if actors.count > 3 {
                actor4Label.text = actors[3]
            } else {
                actor4Label.text = " "
            }
        } else {
            actor1Label.text = " "
            actor2Label.text = " "
            actor3Label.text = " "
            actor4Label.text = " "
        }
        
        if let plot = movie.plot {
            plotTextView.text = plot
        } else {
            plotTextView.text = " "
        }
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
