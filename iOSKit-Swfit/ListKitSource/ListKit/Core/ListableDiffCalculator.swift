//
//  ListableDiffCalculator.swift
//  ListKit
//
//  Created by Allan on 03/05/17.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation

/*
		-- `ListableDiffCalculator` is an internal protocol which bridge the gap 
				between Table/Collection-DiffCalculator

		-- `batchReload(:)` is called to perform batch updates on Table/Collection-View
*/

public protocol ListableDiffCalculator {

	func batchReload(_ sections: [SectionModel])
}
