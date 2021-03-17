//
//  PokemonDB.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import Foundation
import CoreData
import UIKit

// TODO: Implemente protocol like
/*
protocol PokemonDataSource {
    func create(pokemon: Pokemon) -> Bool
    func getAll() -> [Pokemon]?
    func get(byName name: String) -> Pokemon?
    func update(pokemon: Pokemon) -> Bool
    func delete(pokemon: Pokemon) -> Bool
}*/

// TODO: run in background
/*
 let privateContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
 privateContext.persistentStoreCoordinator = managedContext.persistentStoreCoordinator
 privateContext.performBlock {
     // Code in here is now running "in the background" and can safely
     // do anything in privateContext.
     // This is where you will create your entities and save them.
 }
 */

struct Pokemon{
    let name: String
    let image: UIImage?
}

class PokemonDB {
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func create(pokemon: Pokemon) -> Bool {
        
        let cdPokemon = CDPokemon(context: context)
        cdPokemon.name = pokemon.name
        cdPokemon.image = pokemon.image?.pngData()

        return saveContext()
    }
    
    func getAll() -> [Pokemon]? {
        var list: [Pokemon]? = nil
        
        if let result = fetchManagedObject(managedObject: CDPokemon.self) {
             list = result.map {
                let image = $0.image != nil ? UIImage(data: $0.image!) : nil
                return Pokemon(name: $0.name ?? "", image: image )
             }
        }
        return list
    }
    

    func get(byName name: String) -> Pokemon? {
        if let result = getCDPokemon(byName: name) {
            let image = result.image != nil ? UIImage(data: result.image!) : nil
            return Pokemon(name: result.name ?? "", image: image)
        } else {
            return nil
        }
    }
    
    func update(pokemon: Pokemon) -> Bool {
        if let cdPokemon = getCDPokemon(byName: pokemon.name) {
            
            cdPokemon.image = pokemon.image?.pngData()
            return saveContext()
        } else {
            return false
        }
    }
    
    func upsert(pokemon: Pokemon) -> Bool {
        if let cdPokemon = getCDPokemon(byName: pokemon.name) {
            return update(pokemon: pokemon)
        } else {
            return create(pokemon: pokemon)
        }
    }
    
    func delete(pokemon: Pokemon) -> Bool {
        if let cdPokemon = getCDPokemon(byName: pokemon.name) {
            context.delete(cdPokemon)
            return saveContext()
        } else {
            return false
        }
    }
    
    private func saveContext() -> Bool {
        do{
            try context.save()
            return true
        } catch {
            print("Could not save. \(error), \(error.localizedDescription)")
        }
        return false
    }
    
    private func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        var result : [T]?
        
        do{
            result = try context.fetch(managedObject.fetchRequest()) as? [T]
        } catch let error {
            debugPrint(error)
        }
        
        return result
    }
    
    private func getCDPokemon(byName name: String) -> CDPokemon? {
        let fetchRequest = NSFetchRequest<CDPokemon>(entityName: "CDPokemon")
        let predicate = NSPredicate(format: "name==%@", name as CVarArg)

        fetchRequest.predicate = predicate
        var cdPokemon: CDPokemon?
        
        do{
            cdPokemon = try context.fetch(fetchRequest).first
        } catch let error {
            debugPrint(error)
        }
        
        return cdPokemon
    }

}
