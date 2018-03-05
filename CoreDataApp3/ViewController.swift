//
//  ViewController.swift
//  CoreDataApp3
//
//  Created by Geert Van den Berghe on 2/03/18.
//  Copyright © 2018 Geert Van den Berghe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
   
   // var items = [NSManagedObject]()
    var noteArray:[Notes] = []
   // var noteArrayForOtherViewController = [Note]()
    
    @IBOutlet weak var tableView: UITableView!
    
  
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var filteredData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainViewController")
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.selectedScopeButtonIndex = 0
       // self.tableView.tableHeaderView = searchBar
      //  searchBar.returnKeyType = UIReturnKeyType.done
        
        self.fetchData()
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            noteArray = CoreDataHandler.fetchObj()!
            tableView.reloadData()
            return
        }
        
        noteArray = CoreDataHandler.fetchObj(selectedScopeIdx: searchBar.selectedScopeButtonIndex, targetText: searchText)!
        tableView.reloadData()
        
        print(searchText)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return noteArray.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
      /*  let request = NSFetchRequest<NSFetchRequestResult>(entityName:
            "Notes")
        request.returnsObjectsAsFaults = false
        do {
            // Execute Fetch Request
            items = try context.fetch(request) as! [NSManagedObject]
        }
        catch
        {
            //error handling
        } */
        
        do{
            noteArray = try context.fetch(Notes.fetchRequest())
        }catch{
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            noteArray = try context.fetch(Notes.fetchRequest())
        }catch{
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        let todoItem = noteArray[indexPath.row]
       
       
        // WERKT OOK
        // cell.lblTitle!.text = todoItem.notetitle! //todoItem.value(forKey: "notetitle") as! String?
        //cell.lblDate!.text = todoItem.notedetails! //todoItem.value(forKey: "notedate") as! String?
        cell.lblTitle!.text = todoItem.value(forKey: "notetitle") as! String?
        cell.lblDate!.text = todoItem.value(forKey: "notedate") as! String?
        return cell
    }
    
    func reloadData(){
          self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath:
        IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete!!!",
                                                message: "Are you sure you want to delete the note?",
                                                preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Ja" , style: .default){(action) in
            if editingStyle == .delete{
                self.context.delete(self.noteArray[indexPath.row])
                do
                {
                    try self.context.save()
                } catch {
                    print("not saved")
                }
                self.noteArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Nee", style: .default, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        // show alert
        self.present(alertController, animated: true)
        
    }
    
 /*   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let note = noteArray[indexPath.row]
        let editAction = UITableViewRowAction(style: .default, title: "Edit"){(action, indexPath) in
            
        }
    } */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // nieuw scherm openen met Indentifier  "showDetails"
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    //hier data doorgeven naar ander scherm
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController{
            
            // gegevens naar ander scherm sturen en opgevangen door "var notes:Notes? "
            
            detailsViewController.notes = noteArray[(tableView.indexPathForSelectedRow?.row)!]
            
            //WERKT OOK
         /*   detailsViewController._title = noteArray[(tableView.indexPathForSelectedRow?.row)!].notetitle
            detailsViewController._details = noteArray[(tableView.indexPathForSelectedRow?.row)!].notedetails
            detailsViewController._date = noteArray[(tableView.indexPathForSelectedRow?.row)!].notedate */
            
           
        }
    }

}

