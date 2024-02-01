//
//  DetailViewController.swift
//  ProjectPro7
//
//  Created by Chingiz on 31.01.24.
//

import UIKit

protocol EditorDelegate {
    // for structural modifications (addition/deletion)
    func editor(_ editor: DetailViewController, didUpdate notes: [Note])

}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
  
    var notes: [Note]!
    var noteIndex: Int!
    var originalText: String!
    
    var delegate: EditorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        textView.text = notes[noteIndex].text
        originalText = notes[noteIndex].text
        
        setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        
        saveNote()
    }
    
    func setUp(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.tintColor = .orange
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let removeNote = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeNote))
        removeNote.tintColor = .orange
        
        toolbarItems =  [spacer, removeNote]
        navigationController?.isToolbarHidden = false
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object:  nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification,  object: nil)
    }
    
    func setParametrs(notes: [Note], noteIndex: Int) {
        self.notes = notes
        self.noteIndex = noteIndex
    }
    
    @objc func shareTapped() {
        // share text in with activity
        
        //        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        //        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        //        present(vc, animated: true)
        
    }
    
    @objc func removeNote() {
        notes.remove(at: noteIndex)
        notifyDelegateDidUpdate(notes: notes)
        navigationController?.popViewController(animated: true)
        DispatchQueue.global().async { [weak self] in
            if let notes = self?.notes {
                Storage.save(notes: notes)
            }
        }
    }
    
    func saveNote() {
        if textView.text != originalText{
            notes[noteIndex].text = textView.text
            Storage.save(notes: notes)
        } 
        if noteIndex == notes.count{
            Storage.save(notes: notes)

        }
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
            //navigationItem.rightBarButtonItems = [shareButton]
            saveNote() // save each time keyboard is hidden
        }
        else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
            //navigationItem.rightBarButtonItems = [doneButton, shareButton] // buttons appear in reverse order
        }

        textView.scrollIndicatorInsets = textView.contentInset

        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)

    }
    
    func notifyDelegateDidUpdate(notes: [Note]) {
        if let delegate = delegate {
            delegate.editor(self, didUpdate: notes)
        }
    }
    
}
