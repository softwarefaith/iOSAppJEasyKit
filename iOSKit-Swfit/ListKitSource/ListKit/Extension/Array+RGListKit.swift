//
//  Array+ListKit.swift
//  ListKit
//
//  Created by Allan on 13/05/17.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation

extension Array {

	mutating func replace(_ handler: Closure<Element, Bool>, with newElement: Element) {
		guard let idx = index(where: handler) else { return }
		self[idx] = newElement
	}
	func replaced(_ handler: Closure<Element, Bool>, with newElement: Element) -> [Element] {
		var items = self
		items.replace(handler, with: newElement)
		return items
	}
	func appended(with newItems: [Element]) -> [Element] {
		var items = self
		items.append(contentsOf: newItems)
		return items
	}
}
