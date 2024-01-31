//
//  TableViewController.swift
//  ProjectPro7
//
//  Created by Chingiz on 30.01.24.
//

import UIKit

class TableViewController: UITableViewController {
    
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        notes.append(Note(text: "ss", date: Date()))
        notes.append(Note(text: "ss", date: Date()))
        notes.append(Note(text: "ss", date: Date()))
        
        setUp()
    }
    
    func setUp() {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(enterDetailVC))
        navigationController?.navigationBar.tintColor = .orange
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let notesCount = UIBarButtonItem(title: "5 Notes", style: .plain, target: nil, action: nil)
        let addNote = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
        
        notesCount.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11),
            NSAttributedString.Key.foregroundColor : UIColor.darkText
            ], for: .normal)
                
        addNote.tintColor = .orange
        
        toolbarItems =  [spacer, notesCount, spacer, addNote]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func enterDetailVC() {
        notes.append(Note(text: "", date: Date()))
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addNote(){
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }


}
