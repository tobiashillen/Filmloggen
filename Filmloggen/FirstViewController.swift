//
//  ViewController.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-07.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataHelper.setUpCoreData()
        CoreDataHelper.printAllCoreMovies()
        print(CoreDataHelper.isMovieInList(imdbID: "tt0207290", listName: CoreDataHelper.watchListListName))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search"{
            let searchResultTVC : SearchResultTableViewController = segue.destination as! SearchResultTableViewController
            if let searchWord = searchTextField.text {
                searchResultTVC.searchWord = searchWord
            }
        }
        
        if segue.identifier == "filmlog"{
            let filmLogTVC : FilmLogTableViewController = segue.destination as! FilmLogTableViewController
            filmLogTVC.filmList = CoreDataHelper.getAllMoviesInList(listName: CoreDataHelper.filmLogListName)!
        }
        
        if segue.identifier == "watchlist"{
            let filmLogTVC : FilmLogTableViewController = segue.destination as! FilmLogTableViewController
            filmLogTVC.filmList = CoreDataHelper.getAllMoviesInList(listName: CoreDataHelper.watchListListName)!
        }

    }
}

