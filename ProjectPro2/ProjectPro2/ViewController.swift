//
//  ViewController.swift
//  ProjectPro2
//
//  Created by Chingiz on 17.01.24.
//

import UIKit

class ViewController: UITableViewController {
    
    var shopArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addShopItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTable))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        toolbarItems = [space, share]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        
        cell.textLabel?.text = shopArray[indexPath.row]
        return cell
    }
    
    @objc func addShopItem() {
        
        let ac = UIAlertController(title: "Add shop item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        shopArray.insert(item, at: 0)

        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func refreshTable() {
        shopArray.removeAll()
        tableView.reloadData()
    }
    
//    @objc func shareItem() {
//        guard let listShopItem = shopArray.joined(separator: "\n") else {return}
//        
//        let vc = UIActivityViewController(activityItems: [listShopItem], applicationActivities: [])
//        
//        present(vc, animated: true)
//        
//    }
}
