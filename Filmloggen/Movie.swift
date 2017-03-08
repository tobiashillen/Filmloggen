//
//  Movie.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-08.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import Foundation

class Movie {

    let imdbID: String
    let title: String
    let year: Int
    var posterUrl: URL?
    var Plot: String?
    var directors: [String]?
    var actors: [String]?
    var genre: [String]?
    var runningTime: Int?
    var imdbRating: Double?
    var userRating: Int?
    var watchPriority: Int?
    
    init(imdbID : String, title : String, year : Int) {
        
        self.imdbID = imdbID
        self.title = title
        self.year = year
    
    }
    
}
