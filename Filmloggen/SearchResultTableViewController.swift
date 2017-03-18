//
//  SearchResultTableViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-08.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    var webRequestHelper = WebRequestHelper()
    var searchWord: String?
    var searchResults: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let searchWord = searchWord {
            webRequestHelper.getSearchResult(searchString: searchWord, closure: {movies in
                DispatchQueue.main.async {
                    self.searchResults = movies
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultTableViewCell
        cell.movie = searchResults[indexPath.row]
        
        if let title = cell.movie.title {
            if let year = cell.movie.year {
                cell.movieTitleLabel.text = "\(title) (\(year))"
            } else {
                cell.movieTitleLabel.text = "\(title) (-)"
            }
        } else {
            cell.movieTitleLabel.text = "-"
        }
        
        
        if let posterImage = cell.movie.posterImage {
            cell.posterImage.image = posterImage
        } else {
            cell.posterImage.image = #imageLiteral(resourceName: "Tempposter")
            if let posterURL = cell.movie.posterUrl {
                cell.posterImage.image = #imageLiteral(resourceName: "Tempposter")
                webRequestHelper.downloadImage(url: posterURL, closure: { image in
                    DispatchQueue.main.async {
                        cell.movie.posterImage = image
                        self.tableView.reloadData()
                    }
                })
            } else {
                cell.posterImage.image = #imageLiteral(resourceName: "Tempposter")
            }
        }
        
        if let actors = cell.movie.actors {
            if actors.count > 0 {
                cell.actorsLabel.text! = "\(actors[0])"
            }
            if actors.count > 1 {
                cell.actorsLabel.text! += ", \(actors[1])"
            }
        } else {
            if !cell.movie.isAllInfoDownloaded {
                webRequestHelper.getDetails(movie: cell.movie!, closure: { _ in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
                cell.movie.isAllInfoDownloaded = true
            }
        }
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC : DetailViewController = segue.destination as! DetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            detailVC.movie = self.searchResults[indexPath.row]
            webRequestHelper.getDetails(movie: detailVC.movie!, closure: { _ in
                DispatchQueue.main.async {
                    detailVC.setUpView()
                }
            })
        }
    }
}


class SearchResultTableViewCell : UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    var movie : Movie!
    
}
