//
//  Sequence.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation

public extension Sequence where Iterator.Element: Hashable {
	var uniqueElements: [Iterator.Element] {
		return Array(
			Set(self)
		)
	}
}
public extension Sequence where Iterator.Element: Equatable {
	var uniqueElements: [Iterator.Element] {
		return self.reduce([]) { uniqueElements, element in
			
			uniqueElements.contains(element)
				? uniqueElements
				: uniqueElements + [element]
		}
	}
}
