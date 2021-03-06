//
//  FilmLogTableViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-08.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit
import CoreData

class FilmLogTableViewController: UITableViewController {
    
    let webRequestHelper = WebRequestHelper()
    var filmList: [CoreMovie] = []
    var filmLogMode = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LogTableViewCell
        cell.movie = filmList[indexPath.row]
        
        if let title = cell.movie.title {
            cell.titleLabel.text = title
            cell.titleLabel.text = "\(title) (\(Int(cell.movie.year)))"
 
        }
        
        if filmLogMode {
            if let watchdate = cell.movie.watchDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                cell.dateLabel.text = (dateFormatter.string(from: watchdate as Date))
            }
            
            switch cell.movie.userRating {
            case 1:
                cell.userRatingLabel.text = "⭐️"
            case 2:
                cell.userRatingLabel.text = "⭐️⭐️"
            case 3:
                cell.userRatingLabel.text = "⭐️⭐️⭐️"
            case 4:
                cell.userRatingLabel.text = "⭐️⭐️⭐️⭐️"
            case 5:
                cell.userRatingLabel.text = "⭐️⭐️⭐️⭐️⭐️"
            default:
                cell.userRatingLabel.text = "-"
            }
            
        } else {
            cell.titleLabel.font = cell.titleLabel.font.withSize(16)
            cell.dateLabel.text = ""
            cell.userRatingLabel.text = ""
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if filmLogMode {
                filmList[indexPath.row].removeFromLists(CoreDataHelper.getListFromDB(listName: CoreDataHelper.filmLogListName)!)
                
                if !CoreDataHelper.isMovieInList(imdbID: filmList[indexPath.row].imdbID!, listName: CoreDataHelper.watchListListName) {
                    CoreDataHelper.getContext().delete(filmList[indexPath.row])
                }
                
                filmList = CoreDataHelper.getAllMoviesInList(listName: CoreDataHelper.filmLogListName)!
            } else {
                filmList[indexPath.row].removeFromLists(CoreDataHelper.getListFromDB(listName: CoreDataHelper.watchListListName)!)
                
                if !CoreDataHelper.isMovieInList(imdbID: filmList[indexPath.row].imdbID!, listName: CoreDataHelper.filmLogListName) {
                    CoreDataHelper.getContext().delete(filmList[indexPath.row])
                }
                
                filmList = CoreDataHelper.getAllMoviesInList(listName: CoreDataHelper.watchListListName)!
            }
            
            CoreDataHelper.saveContext()
            tableView.reloadData()
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC : DetailViewController = segue.destination as! DetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let movie = Movie(imdbID: filmList[indexPath.row].imdbID!, title: filmList[indexPath.row].title!, year: Int(filmList[indexPath.row].year))
            detailVC.movie = movie
            
            webRequestHelper.getDetails(movie: movie, closure: { _ in
                DispatchQueue.main.async {
                    detailVC.setUpView()
                }
            })
        }
    }
    
}

class LogTableViewCell : UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var userRatingLabel: UILabel!
    var movie : CoreMovie!
    
}
