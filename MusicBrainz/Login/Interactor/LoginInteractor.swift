//
//  LoginInteractor.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class LoginInteractor: LoginInteractorInputProtocol,
    LoginInteractorOutputProtocol{

    var presenter: LoginPresenterProtocol?
    var APIDataManager: LoginAPIDataManagerInputProtocol?
    var localDataManager: LoginLocalDataManagerInputProtocol?
    
    init() {
        // TODO: USE CUSTOM INITIALIZATION IF YOU WANT TO USE DEPENDENCY INJECTION
        // http://ilya.puchka.me/dependency-injection-in-swift/
        APIDataManager = LoginAPIDataManager()
        localDataManager = LoginLocalDataManager()
    }
    
    /**
     * Methods for communication PRESENTER -> INTERACTOR
     */
}
