//
//  PlaceAnnotation.swift
//  MapKitExample
//
//  Created by Ahmed Lotfy on 4/24/16.
//  Copyright © 2016 Ahmed Lotfy. All rights reserved.
//

import MapKit
import AddressBook
import Contacts

class PlaceAnnotation: NSObject, MKAnnotation {
    let title:String?
    let locationName:String
    let discipline:String
    let coordinate: CLLocationCoordinate2D
    
    init( title:String, locationName:String, discipline:String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle:String?{
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let  addressDictionary:[String : AnyObject] = [String(CNPostalAddressStreetKey):subtitle!]
        let placeMark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = title
        return mapItem
    }
}