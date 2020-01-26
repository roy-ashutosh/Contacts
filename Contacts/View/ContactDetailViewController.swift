//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

let contactDetailViewModel = ContactDetailViewModel()

class ContactDetailViewController: UIViewController {
    @IBOutlet weak var detailTableView: UITableView!
    
    let fieldNames : [String] = ["mobile", "email"]
    var detail : ContactDetailModel?
    
    var contactModel : ContactModel?
    var contactDetailModel : ContactDetailModel?
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var messageIcon: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactImage.image = UIImage(named: "placeholder_photo")
        contactName.text = contactModel?.first_name
        
        contactDetailViewModel.getContactDetails(url: contactModel?.url ?? "") { [weak self] response in
            self?.detail = response
            DispatchQueue.main.async {
                print(response)
                self?.detailTableView.reloadData()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("hi")
    }
}

extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fieldNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactDetailTableViewCell
        
//        let detail = contactDetailViewModel.getDetails()
        cell.fieldNameLabel.text = fieldNames[indexPath.row]
        
        if (fieldNames[indexPath.row] == "mobile")
        {
            if let phone = detail?.phone_number, !phone.isEmpty {
                cell.fieldValueLabel.text = phone
                callButton.isEnabled=true
                messageIcon.isEnabled = true
            }
            else{
                cell.fieldValueLabel.text = "-"
                callButton.isEnabled=false
                messageIcon.isEnabled = false
            }
        }
        else if (fieldNames[indexPath.row] == "email")
        {
//            cell.fieldValueLabel.text = detail?.email ?? "-"
            
            if let email = detail?.email, !email.isEmpty{
                cell.fieldValueLabel.text = email
                emailButton.isEnabled=true
            }
            else{
                cell.fieldValueLabel.text = "-"
                emailButton.isEnabled=false
            }
        }
        else
        {
            cell.fieldValueLabel.text = "-"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
