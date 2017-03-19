//
//  CoreDataHelper.swift
//  Filmloggen
//
//  Created by Tobias Hillén on 2017-03-13.
//  Copyright © 2017 Tobias Hillén. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static let filmListEntityName = "FilmList"
    static let coreMovieEntityName = "CoreMovie"
    static let filmLogListName = "Filmlog"
    static let watchListListName = "Watchlist"
    
    
    private init() {
        
    }
    
    class func getContext() -> NSManagedObjectContext {
        return CoreDataHelper.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Filmloggen")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                NSLog("CoreData - Changes saved.")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    class func setUpCoreData() {
        let fetchReq:NSFetchRequest<FilmList> = FilmList.fetchRequest()
        do {
            let results = try CoreDataHelper.getContext().fetch(fetchReq)
            NSLog("CoreData - Film list count:\(results.count)")
            if results.count == 0 {
                NSLog("CoreData - Creating filmlists.")
                
                let filmlog:FilmList = NSEntityDescription.insertNewObject(forEntityName: filmListEntityName, into: CoreDataHelper.getContext()) as! FilmList
                filmlog.listName = filmLogListName
                
                let watchlist:FilmList = NSEntityDescription.insertNewObject(forEntityName: filmListEntityName, into: CoreDataHelper.getContext()) as! FilmList
                watchlist.listName = watchListListName
                
                self.saveContext()
            }
        } catch {
            NSLog("Error: \(error)")
        }
    }
    
    class func doCoreMovieExist(imdbId: String) -> Bool {
        var doExist = false
        let fetchReq:NSFetchRequest<CoreMovie> = CoreMovie.fetchRequest()
        do {
            let results = try CoreDataHelper.getContext().fetch(fetchReq)
            
            for result in results {
                if result.imdbID == imdbId {
                    doExist = true
                }
            }
        } catch {
            NSLog("Error: \(error)")
        }
        return doExist
    }
    
    class func getCoreMovieFromDB(imdbId: String) -> CoreMovie? {
        let fetchReq:NSFetchRequest<CoreMovie> = CoreMovie.fetchRequest()
        do {
            let results = try CoreDataHelper.getContext().fetch(fetchReq)
            
            for result in results {
                if result.imdbID == imdbId {
                    return result
                }
            }
        } catch {
            NSLog("Error: \(error)")
        }
        return nil
    }
    
    class func createCoreMovie(imdbID: String, title: String) -> CoreMovie{
        let coreMovie:CoreMovie = NSEntityDescription.insertNewObject(forEntityName: coreMovieEntityName, into: CoreDataHelper.getContext()) as! CoreMovie
        coreMovie.imdbID = imdbID
        coreMovie.title = title
        self.saveContext()
        return coreMovie
    }
    
    class func isMovieInList(imdbID: String, listName: String) -> Bool {
        var isInList = false
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: coreMovieEntityName)
        request.predicate = NSPredicate(format: "imdbID == \"\(imdbID)\"")
        do {
            let movies = try getContext().fetch(request) as! [CoreMovie]
            for movie in movies {
                for list in movie.lists as! Set<FilmList> {
                    if list.listName == listName {
                        isInList = true
                    }
                }
            }
        } catch {
            NSLog("Error: \(error)")
        }
        return isInList
    }



    class func getListFromDB(listName: String) -> FilmList? {
        let fetchReq:NSFetchRequest<FilmList> = FilmList.fetchRequest()
        do {
            let results = try CoreDataHelper.getContext().fetch(fetchReq)
            
            for result in results {
                if result.listName == listName {
                    return result
                }
            }
        } catch {
            NSLog("Error: \(error)")
        }
        return nil
    }
    class func getAllMoviesInList(listName: String) -> [CoreMovie]? {
        var movieList : [CoreMovie] = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: coreMovieEntityName)
        
        if listName == filmLogListName {
            request.sortDescriptors = [NSSortDescriptor(key: "watchDate", ascending: false)]
        }
        
        do {
            let movies = try getContext().fetch(request) as! [CoreMovie]
            for movie in movies {
                for list in movie.lists as! Set<FilmList> {
                    if list.listName == listName {
                        movieList.append(movie)
                    }
                }
            }
        }catch let error {
            print(error)
        }
        return movieList
    }
    
    class func printAllCoreMovies() {
        let fetchReq:NSFetchRequest<CoreMovie> = CoreMovie.fetchRequest()
        do {
            let results = try CoreDataHelper.getContext().fetch(fetchReq)
            
            for result in results {
                print(result.title ?? "-")
                print(result.lists ?? "-")
                print(result.lists?.value(forKey: "listName") ?? "no name")
            }
        } catch {
            NSLog("Error: \(error)")
        }
    }
}
