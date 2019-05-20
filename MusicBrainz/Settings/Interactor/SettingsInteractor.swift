//
//  SettingsInteractor.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class SettingsInteractor: SettingsInteractorInputProtocol,
    SettingsInteractorOutputProtocol{

    var presenter: SettingsPresenterProtocol?
    var APIDataManager: SettingsAPIDataManagerInputProtocol?
    var localDataManager: SettingsLocalDataManagerInputProtocol?
    
    init() {
        // TODO: USE CUSTOM INITIALIZATION IF YOU WANT TO USE DEPENDENCY INJECTION
        // http://ilya.puchka.me/dependency-injection-in-swift/
        APIDataManager = SettingsAPIDataManager()
        localDataManager = SettingsLocalDataManager()
    }
    
    /**
     * Methods for communication PRESENTER -> INTERACTOR
     */
}
