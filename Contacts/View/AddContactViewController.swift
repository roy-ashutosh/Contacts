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
    
    var addEditType : AddEditMode?
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBAction func doneAction(_ sender: Any) {
        dismissAddEditView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismissAddEditView()
    }
    
    @IBOutlet weak var addContactTableView: UITableView!
    
    var existingDetail : ContactDetailModel?
    
    let fieldNames = ["First Name", "Last Name", "mobile", "email"]
    
    
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

extension AddContactViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddEditContactTableViewCell
        cell.filedName.text = fieldNames[indexPath.row]
        cell.filedName.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 0.5)
        cell.fieldValue.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
