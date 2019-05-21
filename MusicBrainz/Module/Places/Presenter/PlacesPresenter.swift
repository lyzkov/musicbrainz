//
//  PlacesPresenter.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit
import MapKit

final class PlacesPresenter {

    weak private var view: PlacesViewProtocol?
    private let interactor: PlacesInteractorProtocol
    private let wireframe: PlacesWireframeProtocol

    init(interface: PlacesViewProtocol, interactor: PlacesInteractorProtocol, wireframe: PlacesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.wireframe = wireframe

        self.interactor.presenter = self
    }

}

extension PlacesPresenter: PlacesPresenterInputProtocol {

    func load() {
        interactor.loadRegion()
    }

}

extension PlacesPresenter: PlacesPresenterOutputProtocol {

    func present(region: RegionType) {
        view?.present(region: region)
    }

    func show(error: Error) {
        wireframe.presentAlert(from: error)
    }

}
