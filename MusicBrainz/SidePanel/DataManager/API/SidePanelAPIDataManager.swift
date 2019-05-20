//
//  SidePanelAPIDataManager.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit

class SidePanelAPIDataManager: SidePanelAPIDataManagerInputProtocol {


    private let interactor : SidePanelInteractorOutputProtocol?
    
    init(interactor : SidePanelInteractorOutputProtocol) {
        self.interactor = interactor
    }
    
    func makeAPICallToLogoutUser() {
        
    }
    


}
