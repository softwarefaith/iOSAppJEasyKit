//
//  EquatableItemModel.swift
//  ListKit
//
//  Created by Allan on 01/01/17.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation
import UIKit

/*
		-- `EquatableItemModel` is an internal struct that gets injected into 
				dwifft calculator
*/

struct EquatableItemModel: ItemModel, Equatable {
	
	var id: String
	var reuseIdentifier: String
	var height: CGFloat
	var width: CGFloat
	
	init(id: String, reuseIdentifier: String, height: CGFloat, width: CGFloat = 0.0) {
		self.id = id
		self.reuseIdentifier = reuseIdentifier
		self.height = height
		self.width = width
	}

	public static func ==(lhs: EquatableItemModel, rhs: EquatableItemModel) -> Bool {
		return lhs.id == rhs.id
	}
}
