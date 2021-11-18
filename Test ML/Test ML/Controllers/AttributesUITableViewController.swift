//
//  FeaturesUITableViewController.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 16/11/21.
//

import UIKit

class AttributesUITableViewController: UITableViewController {
    
    var attributes = [Attribute]()
    
    private enum ReuseIdentifiers: String {
        case attributeUITableViewCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Características"
        self.configureTableViewControllerUI()
    }
    
    private func configureTableViewControllerUI() {
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = .white
        //self.tableView.estimatedRowHeight = UITableView.automaticDimension
        //self.tableView.rowHeight = UITableView.automaticDimension
        //self.tableView.register(AttributeUITableViewCell2.self, forCellReuseIdentifier: ReuseIdentifiers.attributeUITableViewCell.rawValue)
        self.tableView.register(UINib(nibName: "AttributeUITableViewCell", bundle: nil), forCellReuseIdentifier: ReuseIdentifiers.attributeUITableViewCell.rawValue)
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.attributeUITableViewCell.rawValue, for: indexPath) as? AttributeUITableViewCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        let item = attributes[index]
        
        cell.labelName.text = item.name
        cell.labelValue.text = item.valueName
        cell.contentView.backgroundColor = (index%2 == 0) ? UIColor(red: 197.0/255.0, green: 197.0/255.0, blue: 197.0/255.0, alpha: 1.0) : .white
                
        return cell
    }

}
