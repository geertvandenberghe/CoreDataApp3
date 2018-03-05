//
//  DetailsViewController.swift
//  CoreDataApp3
//
//  Created by Geert Van den Berghe on 2/03/18.
//  Copyright © 2018 Geert Van den Berghe. All rights reserved.
//

import UIKit
import CoreData


class DetailsViewController: UIViewController {

    @IBOutlet weak var lblTitle: UITextField!
    @IBOutlet weak var lblDate: UITextField!
    @IBOutlet weak var lblDetails: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    
    
    //var note: Note?
    //var noteArr:[Notes] = []
    //var note: Notes?
    
    var notes:Notes?  // hier wordt data doorgegeven
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDate.isUserInteractionEnabled = false
        
        if let n = notes{
            lblTitle.text = n.notetitle
            lblDate.text = n.notedate
            lblDetails.text = n.notedetails
        }
        
        print(lblTitle.text!)
        print(lblDate.text!)
        print(lblDetails.text!)
    }
    
    @IBAction func datePicker(_ sender: Any) {
        let date = datePicker.date;
        let format = DateFormatter();
        //kiezen locale (bv. BE, US, ...)
        format.locale = Locale.current
        //kiezen datestyle, er bestaan al templates
        format.dateStyle = .medium
        //idem voor tijd
        format.timeStyle = .medium
        
        lblDate.text = format.string(from:date)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context =  appDelegate.persistentContainer.viewContext
        
        notes?.notedate = lblDate.text
        notes?.notetitle = lblTitle.text
        notes?.notedetails = lblDetails.text
        
        
        do{
            try context.save()
            print("SAVED")
        }catch{
            print(error.localizedDescription)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
