//
//  RGTableViewDiffCalculator.swift
//  ListKit
//
//  Created by Allan on 13/05/17.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation

/*
		-- `RGTableViewDiffCalculator` is an internal class for UITableView 
			  which makes ListKit's design work with Dwiftt's design

		-- its implements `ListableDiffCalculator` protocol which is later used to 
			 perform batch updates
*/

final class RGTableViewDiffCalculator: TableViewDiffCalculator<SectionModel, EquatableItemModel> {
}

extension RGTableViewDiffCalculator: ListableDiffCalculator {

	public func batchReload(_ sections: [SectionModel]) {
		self.sectionedValues = SectionedValues(
			sections.map({ ($0, $0.cells.map({ $0.model })) })
		)
	}
}
