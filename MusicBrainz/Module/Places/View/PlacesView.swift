//
//  PlacesView.swift
//  MusicBrainz
//
//  Created BOGU$ on 20/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//
//

import UIKit
import MapKit

final class PlacesView: UIViewController, PlacesViewProtocol {

    // MARK: - Interface Builder Outlets

    @IBOutlet private weak var mapView: MKMapView!

    // MARK: - Properties

    var presenter: PlacesPresenterInputProtocol?

    // MARK: - View Life Cycle Methods
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.load()
    }

    func present(region: RegionType) {
        mapView.setRegion(MKCoordinateRegion(from: region), animated: true)
    }

    func add(place: PlaceAnnotation) {
        mapView.addAnnotation(place)
    }

    func remove(place: PlaceAnnotation) {
        mapView.removeAnnotation(place)
    }
    
}

extension MKCoordinateRegion {

    init(from region: RegionType) {
        self.init()
        center = CLLocationCoordinate2DMake(region.latitude, region.longitude)
        span.latitudeDelta = region.delta
        span.longitudeDelta = region.delta
    }

}

extension PlaceAnnotation: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }

}
