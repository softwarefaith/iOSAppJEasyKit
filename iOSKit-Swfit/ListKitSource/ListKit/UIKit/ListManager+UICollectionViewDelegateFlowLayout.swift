//
//  ListManager+UICollectionViewDelegateFlowLayout.swift
//  ListKit
//
//  Created by Allan on 06/01/17.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation
import UIKit

/*
		-- `ListManager` conforms to `UICollectionViewDelegateFlowLayout` to provide 
				delegate support for `UICollectionView`
*/

extension ListManager: UICollectionViewDelegateFlowLayout {
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let model = sections[indexPath.section].cells[indexPath.row]
		return model.size
	}
}
