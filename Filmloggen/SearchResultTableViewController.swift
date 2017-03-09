//
//  SearchResultTableViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-08.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    var searchWord: String?
    var tempMovieList: [Movie]!

    override func viewDidLoad() {
        super.viewDidLoad()
        initTempData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initTempData() {
        
        
        let m1 = Movie(imdbID: "tt0088247", title: "The Terminator", year: 1984)
        m1.plot = "A seemingly indestructible humanoid cyborg is sent from 2029 to 1984 to assassinate a waitress, whose unborn son will lead humanity in a war against the machines, while a soldier from that war is sent to protect her at all costs."
        m1.director = "James Cameron"
        m1.actors = ["Arnold Schwarzenegger", "Michael Biehn", "Linda Hamilton", "Paul Winfield"]
        m1.genre = "Action, Sci-Fi"
        m1.runningTime = 107
        m1.imdbRating = 8.0
        m1.userRating = 5
        
        let m2 = Movie(imdbID: "tt0095016", title: "Die Hard", year: 1988)
        m2.plot = "John McClane, officer of the NYPD, tries to save his wife Holly Gennaro and several others that were taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles."
        m2.director = "John McTiernann"
        m2.actors = ["Bruce Willis", "Bonnie Bedelia", "Reginald VelJohnson", "Paul Gleason"]
        m2.genre = "Action, Thriller"
        m2.runningTime = 131
        m2.imdbRating = 8.1
        m2.userRating = 4

        let m3 = Movie(imdbID: "tt0088763", title: "Back to the Future", year: 1985)
        m3.plot = "Marty McFly, a 17-year-old high school student, is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his close friend, the maverick scientist Doc Brown."
        m3.director = "Robert Zemeckis"
        m3.actors = ["Michael J. Fox", "Christopher Lloyd", "Lea Thompson", "Crispin Glover"]
        m3.genre = "Adventure, Comedy, Sci-Fi"
        m3.runningTime = 116
        m3.imdbRating = 8.5
        m3.userRating = 5
        
        tempMovieList = [m1, m2, m3]
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempMovieList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultTableViewCell
        cell.movie = tempMovieList[indexPath.row]
        cell.movieTitleLabel.text = tempMovieList[indexPath.row].title
        if let userRating = tempMovieList[indexPath.row].userRating {
            switch userRating {
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
                cell.userRatingLabel.text = ""
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let detailVC : DetailViewController = segue.destination as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                detailVC.movie = self.tempMovieList[indexPath.row]
            }
    }
    

}


class SearchResultTableViewCell : UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    
    
    var movie : Movie!

}
