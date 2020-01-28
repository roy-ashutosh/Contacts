//
//  AddEditContactTableViewCell.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

protocol AddEditCellDelegate:class {
    func updateValues(cell:AddEditContactTableViewCell, changedText:String)
}

class AddEditContactTableViewCell: UITableViewCell {
    
    weak var delegate:AddEditCellDelegate?
    
    @IBAction func textChanged(_ sender: UITextField) {
        delegate?.updateValues(cell: self, changedText: sender.text ?? "")
    }
    
    @IBOutlet weak var filedName: UILabel!    
    @IBOutlet weak var fieldValue: UITextField!
}
