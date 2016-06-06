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
    
    var places = [PlaceAnnotation]()
    
    struct Coordinates {
        static let Latitude:CLLocationDegrees = 21.282778
        static let Longitude:CLLocationDegrees = -157.829444
        static let RegionRedius:CLLocationDistance = 1000
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        //        let placeAnnotaion = PlaceAnnotation(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: Coordinates.Latitude, longitude: Coordinates.Longitude))
        //        mapView.addAnnotation(placeAnnotaion)
        
        let initialLocation = CLLocation(latitude: Coordinates.Latitude, longitude: Coordinates.Longitude)
        centerMapOnLocaion(initialLocation)
        
        loadInitialData()
        mapView.addAnnotations(places)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    // MARK: - location manager to authorize user location for Maps app
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func loadInitialData(){
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json")
        let data: NSData = NSData(contentsOfFile: fileName!)!

        // 2
        do {
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String : AnyObject]
            print("pp")
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array
            for placeJSON in jsonData!{
                if let placeJSON = placeJSON.array, place = PlaceAnnotation.fromJSON(placeJSON){
                    print("\(place.coordinate.latitude) , \(place.coordinate.longitude)")
                    places.append(place)
                }
            }
        } catch {
            print("json error: \(error)")
        }
        
    }

    func centerMapOnLocaion(location:CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, Coordinates.RegionRedius * 2.0, Coordinates.RegionRedius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

