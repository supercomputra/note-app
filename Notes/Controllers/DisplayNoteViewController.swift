//
//  ViewController.swift
//  Notes
//
//  Created by Zulwiyoza Putra on 10/15/16.
//  Copyright © 2016 Zulwiyoza Putra. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {
    
    var note: Note?
    
    @IBOutlet weak var noteTitleTextField: UITextField!

    @IBOutlet weak var noteContentTextView: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let note = note {
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: .UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func keyboardWasShown(notification: Notification) {
        var info = notification.userInfo!
        let kbSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, (kbSize?.height)!, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        
        var aRect = self.view.frame
        aRect.size.height -= (kbSize?.height)!
        if !aRect.contains(noteContentTextView.frame.origin) {
            self.scrollView.scrollRectToVisible(noteContentTextView.frame, animated: true)
        }
        
    }
    
    func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.noteContentTextView.sizeToFit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listNotesTableViewController = segue.destination as! ListNotesTableViewController
        if let identifier = segue.identifier {
            if identifier == "Cancel" {
                print("Cancel button tapped")
            } else if identifier == "Save" {
                print("Save button tapped")
                if note != nil {
                    let note = self.note ?? Note()
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text ?? ""
                    note.modificationTime = Date()
                    CoreDataHelper.saveNote()
                    listNotesTableViewController.tableView.reloadData()
                } else {
                    let newNote = Note()
                    newNote.title = noteTitleTextField.text ?? ""
                    newNote.content = noteContentTextView.text ?? ""
                    newNote.modificationTime = Date()
                    listNotesTableViewController.notes.append(newNote)
                }
            }
        }
    }


}

