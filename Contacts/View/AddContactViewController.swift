//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

enum AddEditMode {
    case add
    case edit
}

class AddContactViewController: UIViewController {
    
    let contactAddEditVM = ContactAddEditViewModel()
    
    var addEditType : AddEditMode?
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBAction func doneAction(_ sender: Any) {
        print(self.editedFieldValues)
        
        switch addEditType {
        case .add:
            let url = "https://gojek-contacts-app.herokuapp.com/contacts.json"
            contactAddEditVM.updateContactDetails(url: url, httpMethodType: "POST", paramDict: self.editedFieldValues)
        case .edit:
            if let id = existingDetail?.id {
                let url = "https://gojek-contacts-app.herokuapp.com/contacts/\(id).json"
                contactAddEditVM.updateContactDetails(url: url, httpMethodType: "PUT", paramDict: self.editedFieldValues)
            }
        default: break
        }
        
        dismissAddEditView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismissAddEditView()
    }
    
    @IBOutlet weak var addContactTableView: UITableView!
    
    var existingDetail : ContactDetailModel?
    
    let fieldNames = ["First Name", "Last Name", "mobile", "email"]
    
    var editedFieldValues:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Add Contact"
        self.title = ""
        contactImage.image = UIImage.init(named: "placeholder_photo")
        cameraImage.image = UIImage.init(named: "camera_button")
        // Do any additional setup after loading the view.
    }
    
    
    func dismissAddEditView() -> Void {
        if addEditType != nil {
            switch addEditType {
            case .add:
                self.dismiss(animated: true, completion: nil)
            case .edit:
                self.navigationController?.popViewController(animated: true)
            default:
                self.dismiss(animated: true, completion: nil)
            }
        }
        else{
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension AddContactViewController: UITableViewDelegate, UITableViewDataSource, AddEditCellDelegate{
    
    func updateValues(cell: AddEditContactTableViewCell, changedText: String) {
//        saveEditedFieldValues(value: changedText, fieldId: cell.fieldName.text!)
        var key = cell.fieldName.text ?? ""
        key = key.lowercased().replacingOccurrences(of: " ", with: "_")
        saveEditedFieldValues(value: changedText, fieldName: key)
    }
    
    func  saveEditedFieldValues(value:String? , fieldName:String) {
        self.editedFieldValues[fieldName] = value
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddEditContactTableViewCell
        cell.fieldName.text = fieldNames[indexPath.row]
        cell.fieldName.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 0.5)
        
        cell.delegate = self
        cell.fieldValue.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)

        if (fieldNames[indexPath.row] == "First Name")
        {
            if let fname = existingDetail?.first_name, !fname.isEmpty {
                cell.fieldValue.text = existingDetail?.first_name
            }
            else{
                cell.fieldValue.text = ""
            }
        }
        else if (fieldNames[indexPath.row] == "Last Name")
        {
            if let lname = existingDetail?.last_name, !lname.isEmpty {
                cell.fieldValue.text = existingDetail?.last_name
            }
            else{
                cell.fieldValue.text = ""
            }
        }
        else if (fieldNames[indexPath.row] == "mobile")
        {
            if let phone = existingDetail?.phone_number, !phone.isEmpty {
                cell.fieldValue.text = existingDetail?.phone_number
            }
            else{
                cell.fieldValue.text = ""
            }
        }
        else if (fieldNames[indexPath.row] == "email")
        {
            if let mail = existingDetail?.email, !mail.isEmpty {
                cell.fieldValue.text = existingDetail?.email
            }
            else{
                cell.fieldValue.text = ""
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
