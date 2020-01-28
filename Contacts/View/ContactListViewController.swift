//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

let contactlistViewModel = ContactListViewModel()

class ContactListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    @IBAction func addContact(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addEditViewController = storyboard.instantiateViewController(withIdentifier :"AddContactViewController") as! AddContactViewController
        addEditViewController.addEditType =  AddEditMode.add
        let destinationNavigationController = storyboard.instantiateViewController(withIdentifier: "AddContactNavigationController") as! UINavigationController
        destinationNavigationController.pushViewController(addEditViewController, animated: true)
        self.present(destinationNavigationController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        
        contactlistViewModel.getContactList { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    @objc private func refreshTableView() {
        
        contactlistViewModel.getContactList { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactlistViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactListTableViewCell

        let model = contactlistViewModel.cellViewModel(index: indexPath.row)
        
        cell.contactNameLabel.text = model.first_name
        cell.contactImage.image = UIImage(named: "placeholder_photo")
        
        if model.favorite ?? false {
            cell.fauvorite.image = UIImage(named: "home_favourite")
        }
        else{
            cell.fauvorite.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = contactlistViewModel.cellViewModel(index: indexPath.row)

        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"ContactDetailViewController") as! ContactDetailViewController
        viewController.contactModel = model
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
}
