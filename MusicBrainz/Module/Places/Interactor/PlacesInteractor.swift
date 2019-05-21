//
//  PlacesInteractor.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import Foundation

final class PlacesInteractor: PlacesInteractorProtocol {

    weak var presenter: PlacesPresenterOutputProtocol?
    let apiDataManager: PlacesAPIDataManagerInputProtocol
    let locationDataManager: PlacesLocationDataManagerInputProtocol
    
    init(apiDataManager: PlacesAPIDataManagerInputProtocol = PlacesAPIDataManager(),
         locationDataManager: PlacesLocationDataManagerInputProtocol = PlacesDefaultLocationDataManager()) {
        self.apiDataManager = apiDataManager
        self.locationDataManager = locationDataManager
    }
    
    func loadRegion() {
        locationDataManager.region { [unowned self] result in
            switch result {
            case .success(let region):
                self.presenter?.present(region: region)
            case .failure(let error):
                self.presenter?.show(error: error)
            }
        }
    }

}
