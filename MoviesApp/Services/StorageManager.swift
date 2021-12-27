//
//  StorageManager.swift
//  MoviesApp
//
//  Created by Александр on 11.12.21.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Востанавливаем данные из базы
    func fetchData(completion: (Result<[SaveMovie], Error>) -> Void) {
        let fetchRequest = SaveMovie.fetchRequest()
        
        do {
            let movies = try viewContext.fetch(fetchRequest)
            completion(.success(movies))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func save(_ newMovie: Film) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "SaveMovie", in: viewContext) else { return }
        guard let movie = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? SaveMovie else { return }
        movie.title = newMovie.title
        movie.poster = newMovie.poster
        movie.imdbRating = newMovie.imdbRating
        movie.kinopoiskRating = newMovie.kinopoiskRating
        saveContext()
    }
    
    func delete(_ movie: SaveMovie) {
        viewContext.delete(movie)
        saveContext()
    }
}
