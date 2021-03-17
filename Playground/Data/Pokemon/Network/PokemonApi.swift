//
//  PokemonApi.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import Foundation
import UIKit

enum PokeApiError: Error {
    case NullResponse
    case MalformedResponse
}

struct PokemonApi  {
    
    

    let apiUrl = "https://pokeapi.co/api/v2"
    
    func getPokemonList( completion: @escaping (Result<[Pokemon]>) -> Void ){
        let urlString = "\(apiUrl)/pokemon"
        
        performRequest(urlString: urlString){ result in
            if case Result.Failure(let error) = result {
                completion( .Failure(error) )
            }
            
            if case Result.Success(let data) = result {
                if let decodedData = tryParseJson(of: PokemonSet.self, data: data) {
                    
                    let pokemonList = decodedData.results.map { Pokemon(name: $0.name, image: nil) }
                    
                        completion( .Success(pokemonList) )
                    
                }else {
                    completion( .Failure(PokeApiError.MalformedResponse) )
                }
                
            }
        }
        
    }
    
    func getPokemon( byName name: String, completion: @escaping (Result<Pokemon>) -> Void){
        let urlString = "\(apiUrl)/pokemon/\(name)"
        performRequest(urlString: urlString){ result in
            
            if case Result.Failure(let error) = result {
                completion( .Failure(error) )
            }
            
            
            if case Result.Success(let data) = result {
                
                if let decodedData = tryParseJson(of: PokemonItem.self, data: data) {
                    
                    let urlImage = decodedData.sprites.front_shiny
                    
                    // Spaghetti code :(
                    performRequest(urlString: urlImage) { result in
                        
                        if case Result.Failure(let error) = result {
                            completion( .Failure(error) )
                        }
                        
                        if case Result.Success(let data) = result {
                            completion( .Success(Pokemon(name: name, image: UIImage(data: data))))
                            
                        }
                    }
                    
                    
                    completion( .Success(Pokemon(name: name, image: nil)) )
                }else {
                    completion( .Failure(PokeApiError.MalformedResponse) )
                }
                
            }
        }
    }
    
    
    
    func performRequest( urlString: String, completion: @escaping (Result<Data>) -> Void ){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url ){ data, response, error in
                
                if error != nil {
                    completion( .Failure(error!) )
                }
                
                if let safeData = data {
                    completion( .Success(safeData))
                } else {
                    completion( .Failure(PokeApiError.NullResponse) )
                }
                
            }
            task.resume()
        }
    }
    
    func tryParseJson<T : Decodable>( of type: T.Type, data: Data) -> T? {
        
        
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(T.self, from: data)
            return decodeData
        }catch{
            print(error)
        }
        return nil
    }
}
