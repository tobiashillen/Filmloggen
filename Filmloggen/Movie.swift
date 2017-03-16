//
//  Movie.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-08.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import Foundation
import UIKit

class Movie {

    let imdbID: String
    let title: String
    var year: Int?
    var posterUrl: URL?
    var plot: String?
    var director: String?
    var actors: [String]?
    var genre: String?
    var runningTime: Int?
    var imdbRating: Double?
    var userRating: Int?
    var watchDate: Date?
    var watchPriority: Int?
    var posterImage: UIImage?
    var isAllInfoDownloaded = false

    
    init(imdbID : String, title : String) {
        
        self.imdbID = imdbID
        self.title = title
        
    }
    
    init(imdbID : String, title : String, year : Int) {
        
        self.imdbID = imdbID
        self.title = title
        self.year = year
    
    }
}
