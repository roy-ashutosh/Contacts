//
//  AddEditContactTableViewCell.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

class AddEditContactTableViewCell: UITableViewCell,UITextFieldDelegate {
    @IBAction func textChanged(_ sender: Any) {
        
    }
    
    @IBOutlet weak var filedName: UILabel!
    @IBOutlet weak var fieldValue: UITextField!
    
    
}
