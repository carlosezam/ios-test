//
//  HomeViewController.swift
//  Playground
//
//  Created by Mobile 02 on 15/03/21.
//

import UIKit

class HomeViewController: CustomViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var auth = AuthManager()
    //var pokeApi = PokemonApi()
    var pokemonList : [Pokemon] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let repository = PokemonRepository(
        local: PokemonDB(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext),
        remote: PokemonApi())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        
        //storyboard?.instantiateViewController(identifier: T##String)
        //navigationController?.pushViewController(T##viewController: UIViewController##UIViewController, animated: T##Bool)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //showLoadingAlert()
        repository.getAll {
            self.dismisLoadingAlert()
            if case Result.Success(let list) = $0 {
                self.pokemonList = list ?? [Pokemon]()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        /*pokeApi.getPokemonList {
            if case Result.Success(let list) = $0 {
                self.pokemonList = list
                self.tableView.reloadData()
            }
        }*/
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        auth.signOut { result in
            switch result {
            case .Success(_): self.goToSignIn()
            case .Failure(let error): self.showError(error)
            }
        }
    }
    
    func goToSignIn(){
        navigationController?.popToRootViewController(animated: true)
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = pokemonList[ indexPath.row ].name
        return cell
    }
    
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(pokemon: pokemonList[ indexPath.row] )
        //performSegue(withIdentifier: "ListToItem", sender: self)
    }
    
    func showDetails(pokemon: Pokemon){
        guard let vc = storyboard?.instantiateViewController(identifier: "Details", creator: { coder in
            return DetailsViewController(coder: coder, pokemon: pokemon, repository: self.repository)
        }) else {
            fatalError("Failed to laod DetailsViewController from storyboard")
        }
        
        //navigationController?.pushViewController(vc, animated: true)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
