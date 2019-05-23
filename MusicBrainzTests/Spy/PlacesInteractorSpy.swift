//
//  PlacesInteractorSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
@testable import MusicBrainz

final class PlacesInteractorSpy: PlacesInteractorProtocol {

    var presenter: PlacesPresenterOutputProtocol?

    var didLoadRegion = false

    func loadRegion() {
        didLoadRegion = true
    }

    var didLoadPlacesRegion: RegionType?

    var didLoadPlacesSince: Date?

    func loadPlaces(region: RegionType, since: Date) {
        didLoadPlacesRegion = region
        didLoadPlacesSince = since
    }

}
