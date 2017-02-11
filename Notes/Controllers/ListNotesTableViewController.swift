//
//  ListNotesTableViewController.swift
//  Notes
//
//  Created by Zulwiyoza Putra on 10/15/16.
//  Copyright © 2016 Zulwiyoza Putra. All rights reserved.
//

import UIKit
import CoreData

class ListNotesTableViewController: UITableViewController {

    var notes = [Note]() {
        didSet {
            notes.sort { $0.modificationTime! > $1.modificationTime! }
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        let row = indexPath.row
        let note = notes[row]
        cell.noteTitleLabel.text = note.title
        cell.noteContentPreviewLabel.text = note.content
        cell.noteModificationTimeLabel.text = note.modificationTime?.dateToStringConverterHour()

        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataHelper.delete(note: notes[indexPath.row])
            notes = CoreDataHelper.retrieveNotes()
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                
                print("Table view cell tapped")
                let indexPath = tableView.indexPathForSelectedRow!
                let note = notes[indexPath.row]
                let displayNoteViewController = segue.destination as! DisplayNoteViewController
                displayNoteViewController.note = note

            } else if identifier == "addNote" {
                print("Add note button tapped")
            }
        }
    }
    
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        self.notes = CoreDataHelper.retrieveNotes()

        
    }

}
