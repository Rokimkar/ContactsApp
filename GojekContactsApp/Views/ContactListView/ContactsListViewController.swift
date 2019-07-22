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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactListViewModal.contactLists.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListViewModal.contactLists[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListTableViewCell", for: indexPath)
        if let cell = cell as? ContactListTableViewCell{
            cell.bindData(item: contactListViewModal.contactLists[indexPath.section][indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 20, y: 5, width: UIScreen.main.bounds.width, height: 20))
        headerView.backgroundColor = UIColor.init(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        let titleLabel: UILabel = UILabel.init(frame: headerView.frame)
        titleLabel.text = self.contactListViewModal.indexTitles[section]
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .black
        headerView.addSubview(titleLabel)
        return headerView
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.contactListViewModal.indexTitles
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

