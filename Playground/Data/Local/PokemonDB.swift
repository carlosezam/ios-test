//
//  PokemonDB.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import Foundation
import CoreData

class PokemonDB {
    let context: NSManagedObjectContext
    
    init(app: AppDelegate) {
        context = app.persistentContainer.viewContext
    }
    

}
