//
//  PokemonApi.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import Foundation

enum PokeApiError: Error {
    case NullResponse
    case MalformedResponse
}

struct PokemonApi {
    let apiUrl = "https://pokeapi.co/api/v2"
    
    func getPokemonList( completion: @escaping (Result<[Pokemon]>) -> Void ){
        let urlString = "\(apiUrl)/pokemon"
        
        performRequest(urlString: urlString){ result in
            if case Result.Failure(let error) = result {
                completion( .Failure(error) )
            }
            
            if case Result.Success(let data) = result {
                if let decodedData = tryParseJson(of: PokemonSet.self, data: data) {
                    
                    let pokemonList = decodedData.results.map { Pokemon(name: $0.name) }
                    
                    completion( .Success(pokemonList) )
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
