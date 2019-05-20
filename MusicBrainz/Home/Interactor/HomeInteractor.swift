//
//  HomeInteractor.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class HomeInteractor: HomeInteractorInputProtocol,
    HomeInteractorOutputProtocol{

    var presenter: HomePresenterProtocol?
    var APIDataManager: HomeAPIDataManagerInputProtocol?
    var localDataManager: HomeLocalDataManagerInputProtocol?
    
    init() {
        // TODO: USE CUSTOM INITIALIZATION IF YOU WANT TO USE DEPENDENCY INJECTION
        // http://ilya.puchka.me/dependency-injection-in-swift/
        APIDataManager = HomeAPIDataManager()
        localDataManager = HomeLocalDataManager()
    }
    
    /**
     * Methods for communication PRESENTER -> INTERACTOR
     */
}
