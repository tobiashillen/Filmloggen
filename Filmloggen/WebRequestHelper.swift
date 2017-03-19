//
//  WebRequestHelper.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-09.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import Foundation
import UIKit

class WebRequestHelper {
    let apiUrlString = "http://www.omdbapi.com/?"
    let jsonOptions = JSONSerialization.ReadingOptions()
    
    func getSearchResult(searchString: String, closure: @escaping ([Movie]) -> Void) {
        var movies : [Movie] = []
        var page = 1
        let formatedSearchString = searchString.replacingOccurrences(of: " ", with: "+").lowercased()
        if let safeUrlString = "\(apiUrlString)s=\(formatedSearchString)&type=movie&page=\(page)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            var pages = 0
            
            self.getData(searchQuery: url, closure: { data in
                let moviesForPage = self.parseSearchResults(data: data, pageCountClosure: { pageCount in
                    if pageCount > 10 {
                        pages = 10
                    } else {
                        pages = pageCount
                    }
                })
                
                movies = moviesForPage + movies
                closure(movies)
                
                if pages > 1 {
                    for _ in 2...pages {
                        page += 1
                        if let safeUrlString = "\(self.apiUrlString)s=\(formatedSearchString)&type=movie&page=\(page)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                            let url = URL(string: safeUrlString) {
                            var test = page
                            self.getData(searchQuery: url, closure: { data in
                                let moviesForPage = self.parseSearchResults(data: data, pageCountClosure: {_ in })
                                test += 1
                                movies += moviesForPage
                                closure(movies)
                            })
                        }
                    }
                }
            })
        }
    }
    
    func parseSearchResults(data: Data, pageCountClosure: @escaping (Int) -> Void) -> [Movie] {
        var resultMovies : [Movie] = []
        do {
            if let parsed = try JSONSerialization.jsonObject(with: data, options: jsonOptions) as? [String:Any] {
                
                if let totalResultsString = parsed["totalResults"] as? String,
                    let totalResults = Int(totalResultsString) {
                    var numberOfPages = totalResults/10
                    if (totalResults % 10 != 0) {
                        numberOfPages += 1
                    }
                    
                    pageCountClosure(numberOfPages)
                    
                    if let searchResult = parsed["Search"] as? [[String:String]] {
                        for result in searchResult {
                            if let title = result["Title"],
                                let yearString = result["Year"],
                                let imdbID = result["imdbID"],
                                let poster = result["Poster"]{
                                let movie = Movie(imdbID: imdbID, title: title)
                                if let year = Int(yearString)  {
                                    movie.year = year
                                }
                                if poster != "N/A" {
                                    movie.posterUrl = URL(string: poster)
                                }
                                resultMovies.append(movie)
                            } else {
                                NSLog("Faild to get values from JSON.")
                            }
                        }
                    } else {
                        NSLog("No search results found!")
                    }
                }
            } else {
                NSLog("Failed to cast from json.")
            }
        }
        catch let parseError {
            NSLog("Failed to parse json: \(parseError)")
        }
        return resultMovies
    }
    
    func getDetails(movie: Movie, closure: @escaping (Void) -> Void) {
        
        if let safeUrlString = "\(apiUrlString)i=\(movie.imdbID)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            
            self.getData(searchQuery: url, closure: { data in
                self.parseDetails(data: data, movie: movie)
                closure()
            })
        }
    }    
    
    func parseDetails(data: Data, movie: Movie) {
        do {
            if let parsed = try JSONSerialization.jsonObject(with: data, options: jsonOptions) as? [String:String] {
                
                if movie.posterUrl == nil {
                    if let poster = parsed["Poster"] {
                        if poster != "N/A" {
                            movie.posterUrl = URL(string: poster)
                        }
                    }
                }
                
                if let runtime = parsed["Runtime"], let genre = parsed["Genre"],
                    let director = parsed["Director"], let actors = parsed["Actors"],
                    let plot = parsed["Plot"], let imdbRating = parsed["imdbRating"] {
                    movie.runningTime = Int(runtime.components(separatedBy: CharacterSet.decimalDigits.inverted)
                        .joined())
                    
                    if genre != "N/A" {
                        movie.genre = genre
                    }
                    
                    if director != "N/A" {
                        movie.director = director
                    }
                    
                    if actors != "N/A" {
                        movie.actors = actors.components(separatedBy: ", ")
                    }
                    
                    if plot != "N/A" {
                        movie.plot = plot
                    }
                    movie.imdbRating = Double(imdbRating)
                }
            } else {
                NSLog("Failed to cast from json.")
            }
        }
        catch let parseError {
            NSLog("Failed to parse json: \(parseError)")
        }
    }
    
    func getData(searchQuery: URL, closure: @escaping (Data) -> Void){
        let request = URLRequest(url: searchQuery)
        let task = URLSession.shared.dataTask(with: request) {
            (maybeData: Data?, response: URLResponse?, error: Error?) in
            if let actualData = maybeData {
                closure(actualData)
            } else {
                NSLog("No data received.")
            }
        }
        task.resume()
    }
    
    func downloadImage(url: URL, closure: @escaping (UIImage) -> Void) {
        getData(searchQuery: url, closure: { data in
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    closure(image)
                }
            }
            
        })
    }
}
