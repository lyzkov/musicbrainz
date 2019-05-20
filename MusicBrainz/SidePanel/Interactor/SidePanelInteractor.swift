//
//  SidePanelInteractor.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit


class  SidePanelInteractor:  SidePanelInteractorInputProtocol,
     SidePanelInteractorOutputProtocol{

    var presenter:  SidePanelPresenterProtocol?
    var APIDataManager:  SidePanelAPIDataManagerInputProtocol?
    var localDataManager:  SidePanelLocalDataManagerInputProtocol?
    
    init() {
        self.APIDataManager =  SidePanelAPIDataManager(interactor: self)
    }
    
    func logoutUser() {
        
    }
    
    func directUserAsPerServerResponseForLogout(response: String) {
        
    }

}
