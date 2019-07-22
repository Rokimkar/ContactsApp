//
//  ViewController.swift
//  GojekContactsApp
//
//  Created by S@nchit on 15/07/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

final class ContactsListViewController: UIViewController {
    
    @IBOutlet weak var contactListTableView: UITableView!
    private var contactListViewModal: ContactListViewModal = ContactListViewModal.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContactListTableView()
        setupNavigationBarButtons()
        contactListViewModal.fetchContacts {[weak self] (_) in
            self?.contactListTableView.reloadData()
        }
        self.view.backgroundColor = .white
    }

    private func setupContactListTableView(){
        self.contactListTableView.dataSource = self
        self.contactListTableView.delegate = self
        self.contactListTableView.register(UINib.init(nibName: "ContactListTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactListTableViewCell")
        self.contactListTableView.backgroundColor = .clear
    }
    
    private func setupNavigationBarButtons(){
        self.title = "Contacts"
        let leftItem = UIBarButtonItem(title: "Group", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewContact))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func addNewContact(){
        let addContactVC : AddContactViewController = AddContactViewController(nibName: "AddContactViewController", bundle: nil)
        addContactVC.title = "New Contact"
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: addContactVC)
        self.present(navigationController, animated: true) {
            //
        }
    }
}

extension ContactsListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListViewModal.sortedContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCell", for: indexPath)
        if let cell = cell as? ContactListTableViewCell{
            cell.bindData(item: contactListViewModal.sortedContacts[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension ContactsListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle contact selection
        let detailVC: ContactDetailViewController = ContactDetailViewController(nibName: "ContactDetailViewController", bundle: nil)
        detailVC.contactViewModel = contactListViewModal.sortedContacts[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

