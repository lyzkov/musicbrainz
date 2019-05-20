//
//  HomePresenter.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class HomePresenter: HomePresenterProtocol {

    weak private var view: HomeViewProtocol?
    private let interactor: HomeInteractorInputProtocol
    private let wireframe: HomeWireframeProtocol

    init(interface: HomeView, interactor: HomeInteractorInputProtocol, wireframe: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.wireframe = wireframe

        self.interactor.presenter = self
    }

}
