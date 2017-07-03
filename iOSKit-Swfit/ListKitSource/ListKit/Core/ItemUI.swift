//
//  ItemUI.swift
//  ListKit
//
//  Created by Allan on 04/01/17.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation

/*
		-- conform custom UITableViewCell or UICollectionViewCell to `ItemUI` 
			 protocol to make sure that ListKit calls `configure(withModel:)` method

		-- ListKit internally calls `configure(withModel:)` inside
			`cellForRowAt(:)` (for table) & `cellForItemAt(:)` (for collection-view)
*/

public protocol ItemUI {
	
	func configure(withModel model: ItemModel)
}
