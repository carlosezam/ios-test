//
//  DetailsViewController.swift
//  Playground
//
//  Created by Mobile 02 on 17/03/21.
//

import Foundation
import UIKit

class DetailsViewController: CustomViewController {
    var pokemon: Pokemon
    var repository: PokemonRepository
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    init?(coder: NSCoder, pokemon: Pokemon, repository: PokemonRepository){
        self.pokemon = pokemon
        self.repository = repository
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create the view controller with a user.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLoadingAlert()
        repository.get(byName: pokemon.name){ result in
            self.dismisLoadingAlert()
            if case Result.Failure(let error) = result {
                print(error)
            }
            if case Result.Success(let pokemon) = result {
                DispatchQueue.main.async {
                    self.updateUi(pokemon: pokemon)
                }
            }
            
        }
    }
    
    func updateUi(pokemon: Pokemon?){
        if let pokemon = pokemon {
            pokemonImage.image = pokemon.image
            pokemonName.text = pokemon.name
        }
    }
    
}
