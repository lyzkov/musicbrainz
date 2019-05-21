//
//  PlacesViewSpy.swift
//  MusicBrainzTests
//
//  Created by BOGU$ on 21/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

@testable import MusicBrainz

final class PlacesViewSpy: PlacesViewProtocol {

    var presenter: PlacesPresenterInputProtocol?

    var didPresentRegion: RegionType?

    func present(region: RegionType) {
        didPresentRegion = region
    }

}
