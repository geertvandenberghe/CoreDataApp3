//
//  SecondViewController.swift
//  CoreDataApp3
//
//  Created by Geert Van den Berghe on 2/03/18.
//  Copyright © 2018 Geert Van den Berghe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblTitle: UITextField!
    @IBOutlet weak var lblDetails: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var note:[Notes]? = nil
    var strDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        strDate = format.string(from:date)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        print("SAVE")
        if lblTitle.text != "" && lblDetails.text != ""{
            if strDate == nil || strDate == ""{
                strDate = "No date selected!!!"
            }
            CoreDataHandler.storeObj(title: lblTitle.text!, message: lblDetails.text!, date: strDate!)
           /* note = CoreDataHandler.fetchObj()
            
            for i in note! {
                print(i.notetitle!)
                print(i.notedetails!)
            } */
             dismiss(animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Oooops!!!",
                                                    message: "Add data to the text fields",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK" , style: .default, handler: nil)
             alertController.addAction(okAction)
            // show alert
            self.present(alertController, animated: true)
        }

    }
    
    @IBAction func btnCancel(_ sender: Any) {
        print("CANCEL")
        dismiss(animated: true, completion: nil)
    }
    
}
