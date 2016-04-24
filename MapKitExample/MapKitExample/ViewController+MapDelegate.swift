//
//  ViewController+MapDelegate.swift
//  MapKitExample
//
//  Created by Ahmed Lotfy on 4/24/16.
//  Copyright © 2016 Ahmed Lotfy. All rights reserved.
//

import MapKit

extension ViewController: MKMapViewDelegate{
    
    // 1
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if let annotation = annotation as? PlaceAnnotation{
            let identifier = "pin"
            var view : MKPinAnnotationView
            if let dequeueView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
                dequeueView.annotation = annotation
                view = dequeueView
            }else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
            return view
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! PlaceAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}

