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
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        if let title = movie?.title,
            let year = movie?.year {
            titleLabel.text = "\(title) (\(year))"
        } else {
            NSLog("No movie information found.")
        }
        if let runningTime = movie?.runningTime,
            let genre = movie?.genre,
            let imdbRating = movie?.imdbRating,
            let director = movie?.director,
            let actors = movie?.actors,
            let plot = movie?.plot{
            runningTimeLable.text = "\(runningTime) minuter"
            genreLabel.text = genre
            imdbRatingLabel.text = "IMDB: \(imdbRating)"
            directorLabel.text = "Regi: \(director)"
            actor1Label.text = actors[0]
            actor2Label.text = actors[1]
            actor3Label.text = actors[2]
            actor4Label.text = actors[3]
            plotTextView.text = plot
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
