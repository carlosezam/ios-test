//
//  PokemonRepository.swift
//  Playground
//
//  Created by Mobile 02 on 17/03/21.
//

import Foundation



class PokemonRepository {
    let local: PokemonDB
    let remote: PokemonApi
    
    init(local: PokemonDB, remote: PokemonApi) {
        self.local = local
        self.remote = remote
    }
    
    func getAll( completion: @escaping (Result<[Pokemon]?>) -> Void ){
        
        
        let reachability = Reachability.isConnectedToNetwork()
        
        if( reachability ){
            remote.getPokemonList { result in
                
                if case Result.Failure(let error) = result {
                    completion( .Failure(error) )
                }
                
                if case Result.Success(let data) = result {
                    
                    for p in data {
                        self.local.upsert(pokemon: p)
                    }
                    
                    completion( .Success(data) )
                    
                }
               
            }
        } else {
            let data = local.getAll()
            completion( .Success(data) )
          
        }
    }
}
