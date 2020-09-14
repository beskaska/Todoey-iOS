//
//  DataModel.swift
//  Todoey
//
//  Created by Athena Imelda on 9/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class DataModel {
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var categoryArray: [Category] = []
	var itemArray: [Item] = []
	var currentCategory: Category? {
		didSet {
			loadItems()
		}
	}
	
	init() {
		loadCategories()
	}
	
	func saveChanges() {
		do {
			try context.save()
		} catch {
			print("Error saving context: \(error)")
		}
	}
	
	//MARK: - Category Methods
	
	func loadCategories() {
		let request = NSFetchRequest<Category>(entityName: "Category")

		do {
			categoryArray = try context.fetch(request)
		} catch {
			print("Error fetching data from context: \(error)")
		}
	}
	
	func addNewCategory(with title: String) {
		let NewCategory = Category(context: context)
		
		NewCategory.name = title
		categoryArray.append(NewCategory)
		saveChanges()
	}
	
	func setCurrentCategory(at index: Int) {
		currentCategory = categoryArray[index]
	}
	
	//MARK: - Item Methods
	
	func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), and predicate: NSPredicate? = nil) {
		
		let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES[dc] %@", currentCategory!.name!)
		
		if let additionalPredicate = predicate {
			request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
		} else {
			request.predicate = categoryPredicate
		}
		
		do {
			itemArray = try context.fetch(request)
		} catch {
			print("Error fetching data from context: \(error)")
		}
	}
	
	func addNewItem(with title: String) {
		let newItem = Item(context: context)
		
		newItem.title = title
		newItem.done = false
		newItem.parentCategory = currentCategory
		itemArray.append(newItem)
		saveChanges()
	}
	
	func toggleCheckBox(on cell: Int) {
		itemArray[cell].done = !itemArray[cell].done
		saveChanges()
	}
	
	func searchItem(contains text: String) {
		let request = NSFetchRequest<Item>(entityName: "Item")
		let predicate = NSPredicate(format: "title CONTAINS[dc] %@", text)

		loadItems(with: request, and: predicate)
	}
}
