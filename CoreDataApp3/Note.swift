//
//  Note.swift
//  CoreDataApp3
//
//  Created by Geert Van den Berghe on 2/03/18.
//  Copyright © 2018 Geert Van den Berghe. All rights reserved.
//

import UIKit

class Note {
    var notetitle: String
    var notedetails: String
    var notedate: String
    
    init(title: String, details: String, date: String) {
        self.notetitle = title
        self.notedetails = details
        self.notedate = date
        
        // image = UIImage(named: self.name)!
    }
}
