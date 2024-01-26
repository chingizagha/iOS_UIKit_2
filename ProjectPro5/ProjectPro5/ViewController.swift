//
//  ViewController.swift
//  ProjectPro5
//
//  Created by Chingiz on 26.01.24.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Countries]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJson), with: nil)
    }
    
    @objc func fetchJson() {
        
        var urlString: String!
        urlString = "https://restcountries.com/v3.1/all"
        
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parseJSON(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "Promlem with the feed", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        
    }
    
    func parseJSON(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonCountries = try? decoder.decode([Countries].self, from: json){
            countries = jsonCountries
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
        else{
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name.common
        if let imageUrl = URL(string: country.flags.png) {
                   downloadImage(from: imageUrl) { (image) in
                       DispatchQueue.main.async {
                           cell.imageView?.image = image
                           cell.imageView?.layer.borderColor = UIColor.black.cgColor
                           cell.imageView?.layer.borderWidth = 0.1
                           cell.imageView?.layer.cornerRadius = 5
                       }
                   }
               }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.name = countries[indexPath.row].name.common
//        vc.capital = countries[indexPath.row].capital[0]
        if let imageUrl = URL(string: countries[indexPath.row].flags.png) {
                   downloadImage(from: imageUrl) { (image) in
                       // Update the cell's image on the main thread
                       DispatchQueue.main.async {
                           vc.image = image
                       }
                   }
               }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let error = error {
                   print("Error downloading image: \(error)")
                   completion(nil)
               } else if let data = data, let image = UIImage(data: data) {
                   completion(image)
               } else {
                   completion(nil)
               }
           }.resume()
       }
    

    
    


}

