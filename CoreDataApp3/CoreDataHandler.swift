//
//  CoreDataHandler.swift
//  CoreDataApp3
//
//  Created by Geert Van den Berghe on 2/03/18.
//  Copyright © 2018 Geert Van den Berghe. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
  /*  struct oneNote{
        var noteTitle: String?
        var noteMessage: String?
        var noteDate: String?
        
        init() {
            noteTitle = ""
            noteMessage = ""
            noteDate = ""
        }
        
        init(title:String, message:String, date:String){
            self.noteTitle = title
            self.noteMessage = message
            self.noteDate = date
        }
        
        init(title:String, message:String){
            self.noteTitle = title
            self.noteMessage = message
        }
    }  */
    
    public class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    //storeObj into core data
    class func storeObj(title:String, message:String, date:String){
     let context = getContext()
     
     //let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)
     //let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
     let managedObj = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context)
     
     managedObj.setValue(title, forKey: "notetitle")
     managedObj.setValue(message, forKey: "notedetails")
     managedObj.setValue(date, forKey: "notedate")
     
     do{
        try context.save()
        print("SAVED")
     }catch{
        print(error.localizedDescription)
     }
     
    }
    
    // WITHOUT SEARCH
    // fetch all the object from coredata
   /* class func fetchObj() -> [Notes]?{
        // var array = [oneNote]()
        
        //let fetchRequest:NSFetchRequest<NSFetchRequestResult> (entityName: "Notes")
       
        let context = getContext()
        var note:[Notes]? = nil
        
        do{
            //note = try context.fetch(Notes.fetchRequest())
             note = try context.fetch(Notes.fetchRequest())
            return note
        }catch{
            return note
        }
    } */
    
    class func fetchObj(selectedScopeIdx:Int?=nil, targetText:String?=nil) -> [Notes]?{
        
        let context = getContext()
        var note:[Notes]? = nil
        
        //let fetchRequest:NSFetchRequest<NSFetchRequestResult> (entityName: "Notes")
        let fetchRequest:NSFetchRequest<Notes> = Notes.fetchRequest()
    
        if selectedScopeIdx != nil && targetText != nil{
            let filterKeyword = "notetitle"  // field from coredata
            let predicate = NSPredicate(format:"\(filterKeyword) contains[c] %@", targetText!)
            fetchRequest.predicate = predicate
        }
       
    
        do{
            //note = try context.fetch(Notes.fetchRequest())
            note = try context.fetch(fetchRequest)
            return note
        }catch{
            return note
        }
    }
    
    
    
}

