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
    
    class func fromJSON(json:[JSONValue]) -> PlaceAnnotation?{
        //1
        var title: String
        if let titleOrNil = json[16].string{
            title = titleOrNil
        }else{
            title = ""
        }
        let locationName = json[12].string
        let discipline = json[15].string
        
        // 2
        let latitude = (json[18].string! as NSString).doubleValue
        let longitude = (json[19].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // 3
        return PlaceAnnotation(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate)
    }
    
    // pinColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    func pinColor() -> UIColor  {
        switch discipline {
        case "Default":
            return MKPinAnnotationView.redPinColor()
        case "Destination":
            return MKPinAnnotationView.purplePinColor()
        default:
            return MKPinAnnotationView.greenPinColor()
        }
    }
    
}