//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
	
	var dataModel: DataModel?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

	//MARK: - Tableview Datasource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataModel!.itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableItemCell, for: indexPath)
		
		cell.textLabel?.text = dataModel!.itemArray[indexPath.row].title
		cell.accessoryType = dataModel!.itemArray[indexPath.row].done ? .checkmark : .none
		cell.textLabel?.numberOfLines = 0
		return cell
	}
	
	//MARK: - Tableview Delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		dataModel!.toggleCheckBox(on: indexPath.row)
		tableView.reloadData()
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK: - Add New Item
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			if let safeText = textField.text, safeText != "" {
				self.dataModel!.addNewItem(with: safeText)
				self.tableView.reloadData()
			}
		}
		
		alert.addTextField { (alertTextField) in
			textField = alertTextField
			textField.placeholder = "Create new item..."
		}
		alert.addAction(action)
		present(alert, animated: true)
	}
}

//MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		dataModel!.searchItem(contains: searchBar.text!)
		tableView.reloadData()
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if (searchText == "") {
			dataModel!.loadItems()
			tableView.reloadData()
			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}
		}
	}
}
