//
//  SettingsPresenter.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class SettingsPresenter: SettingsPresenterProtocol {

    weak private var view: SettingsViewProtocol?
    private let interactor: SettingsInteractorInputProtocol
    private let wireframe: SettingsWireframeProtocol

    init(interface: SettingsView, interactor: SettingsInteractorInputProtocol, wireframe: SettingsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.wireframe = wireframe

        self.interactor.presenter = self
    }

}
