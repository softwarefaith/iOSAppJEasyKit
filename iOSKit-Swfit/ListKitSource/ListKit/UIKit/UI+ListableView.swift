//
//  UI+ListableView.swift
//  ListKit
//
//  Created by Allan on 06/01/17.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation
import UIKit

/*
		-- table/collection-view conforms to `ListableView` to bridge the gap and 
			 provide relevant information
*/

extension UITableView: ListableView {

	public var _delegate: ListableViewDelegate? {
		get { return delegate as? ListableViewDelegate }
		set { delegate = newValue as? UITableViewDelegate}
	}
	public var _dataSource: ListableViewDataSource? {
		get { return dataSource as? ListableViewDataSource }
		set { dataSource = newValue as? UITableViewDataSource }
	}
	public func reload() {
		reloadData()
	}
	public var diffCalculator: ListableDiffCalculator {
		return RGTableViewDiffCalculator(tableView: self)
	}
}

extension UICollectionView: ListableView {

	public var _delegate: ListableViewDelegate? {
		get { return delegate as? ListableViewDelegate }
		set { delegate = newValue as? UICollectionViewDelegate }
	}
	public var _dataSource: ListableViewDataSource? {
		get { return dataSource as? ListableViewDataSource }
		set { dataSource = newValue as? UICollectionViewDataSource }
	}
	public func reload() {
		reloadData()
	}
	public var diffCalculator: ListableDiffCalculator {
		return RGCollectionViewDiffCalculator(collectionView: self)
	}
}
