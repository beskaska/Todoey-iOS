//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Athena Imelda on 9/14/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

	var dataModel = DataModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	// MARK: - TableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return dataModel.categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCategoryCell, for: indexPath)

		cell.textLabel?.text = dataModel.categoryArray[indexPath.row].name
		cell.textLabel?.numberOfLines = 0

        return cell
    }

	//MARK: - TableView Delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		dataModel.setCurrentCategory(at: indexPath.row)
		performSegue(withIdentifier: K.segueToItems, sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! TodoListViewController

		destinationVC.dataModel = dataModel
	}
	
	//MARK: - Add New Category
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
		var textField = UITextField()
		
		alert.addTextField { (alertTextField) in
			textField = alertTextField
			textField.placeholder = "Create new category..."
		}
		alert.addAction(UIAlertAction(title: "Add", style: .default) { (action) in
			self.dataModel.addNewCategory(with: textField.text!)
			self.tableView.reloadData()
		})
		
		present(alert, animated: true)
	}
}
