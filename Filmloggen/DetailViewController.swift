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
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var watchListButton: UIButton!
    
    let orangeColor = UIColor(red: 255/255, green: 102/255, blue: 0, alpha: 1)
    let grayColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    var movie: Movie!
    let webRequestHelper = WebRequestHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        if let url = movie.posterUrl {
            webRequestHelper.downloadImage(url: url, closure: { image in
                self.posterImage.image = image
            })
        }
    }
    
    func setUpView() {
        if CoreDataHelper.isMovieInList(imdbID: movie.imdbID, listName: CoreDataHelper.watchListListName) {
            disableWatchListButton()
        }
        
        
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
    
    @IBAction func onWatchListButtonPressed(_ sender: UIButton) {
        var coreMovie : CoreMovie!
        
        if CoreDataHelper.doCoreMovieExist(imdbId: movie.imdbID) {
            coreMovie = CoreDataHelper.getCoreMovieFromDB(imdbId: movie.imdbID)
        } else {
            coreMovie = CoreDataHelper.createCoreMovie(imdbID: movie.imdbID, title: movie.title)
        }
        
        if let year = movie.year {
            coreMovie.year = Int16(year)
        }
        
        let watchlist = CoreDataHelper.getListFromDB(listName: CoreDataHelper.watchListListName)
        
        watchlist?.addToMovies(coreMovie)
        CoreDataHelper.saveContext()
        disableWatchListButton()
    }
    
    func disableWatchListButton() {
        watchListButton.isEnabled = false
        watchListButton.setTitleColor(grayColor, for: .normal)
        watchListButton.setTitle("Ligger i din vill se-lista", for: .normal)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let saveToLogVC : SaveToLogViewController = segue.destination as! SaveToLogViewController
            saveToLogVC.movie = movie
    }

}
