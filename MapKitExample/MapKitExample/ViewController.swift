//
//  ViewController.swift
//  MapKitExample
//
//  Created by Ahmed Lotfy on 4/24/16.
//  Copyright © 2016 Ahmed Lotfy. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    struct Coordinates {
        static let Latitude:CLLocationDegrees = 21.282778
        static let Longitude:CLLocationDegrees = -157.829444
        static let RegionRedius:CLLocationDistance = 1000
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        let placeAnnotaion = PlaceAnnotation(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: Coordinates.Latitude, longitude: Coordinates.Longitude))
        mapView.addAnnotation(placeAnnotaion)
        
        let initialLocation = CLLocation(latitude: Coordinates.Latitude, longitude: Coordinates.Longitude)
        centerMapOnLocaion(initialLocation)
    }

    func centerMapOnLocaion(location:CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, Coordinates.RegionRedius * 2.0, Coordinates.RegionRedius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

