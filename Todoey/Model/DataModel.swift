//
//  DataModel.swift
//  Todoey
//
//  Created by Athena Imelda on 9/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct DataModel {
	var itemArray: [Item] = []
	let dataFilePath: URL?
	let decoder = PropertyListDecoder()
	let encoder = PropertyListEncoder()
	
	init() {
		dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(K.defaultKeyForArray)
		if dataFilePath != nil {
			loadItems(url: dataFilePath!)
		}
	}
	
	mutating func loadItems(url: URL) {
		do {
			let data = try Data(contentsOf: url)
			itemArray = try decoder.decode([Item].self, from: data)
		} catch {
			print(error)
		}
	}
	
	func saveItems() {
		do {
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath!)
		} catch {
			print(error)
		}
		
	}
	
	mutating func addNewItem(with title: String) {
		itemArray.append(Item(title: title))
		saveItems()
	}
	
	mutating func toggleCheckBox(on cell: Int) {
		itemArray[cell].done = !itemArray[cell].done
		saveItems()
	}
}
