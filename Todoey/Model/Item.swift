//
//  Item.swift
//  Todoey
//
//  Created by Athena Imelda on 9/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct Item: Codable {
	let title: String
	var done: Bool = false
}
