//
//  ViewController.swift
//  ProjectPro7
//
//  Created by Chingiz on 31.01.24.
//

import UIKit

class ViewController: UITableViewController, EditorDelegate {

    var notes = [Note]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        
        notes = Storage.load()
        setUp()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Edit this func later
        setUp()
        
        tableView.reloadData()
    }
    

    func setUp() {
           title = "Notes"
           navigationController?.navigationBar.prefersLargeTitles = true
           view.backgroundColor = .white
           navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(enterEditMode))
           navigationController?.navigationBar.tintColor = .orange
           
           
           let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let notesCount = UIBarButtonItem(title: "\(notes.count) Notes", style: .plain, target: nil, action: nil)
           let addNote = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
           
           notesCount.setTitleTextAttributes([
               NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11),
               NSAttributedString.Key.foregroundColor : UIColor.darkText
               ], for: .normal)
                   
           addNote.tintColor = .orange
           
           toolbarItems =  [spacer, notesCount, spacer, addNote]
           navigationController?.isToolbarHidden = false
        
       
       }
       
       @objc func enterEditMode() {
           
       }
       
       @objc func addNote(){
           notes.append(Note(text: "", date: Date()))
           Storage.save(notes: notes)
           if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
               vc.setParametrs(notes: notes, noteIndex: notes.count - 1)
               navigationController?.pushViewController(vc, animated: true)
               tableView.reloadData()
           }
       }
       
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return notes.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
           cell.textLabel?.text = dateFormat(notes[indexPath.row].date)
           cell.detailTextLabel?.text = "\(notes[indexPath.row].text)"
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
           vc?.setParametrs(notes: notes, noteIndex: indexPath.row)
           navigationController?.pushViewController(vc!, animated: true)
       }
    
    func dateFormat(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yy"
        
        let formatedDate = dateFormatter.string(from: date)
        return formatedDate
    }
    

    func editor(_ editor: DetailViewController, didUpdate notes: [Note]) {
            self.notes = notes
    }

}

