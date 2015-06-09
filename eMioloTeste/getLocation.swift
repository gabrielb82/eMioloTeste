//
//  getLocation.swift
//  eMioloTeste
//
//  Created by Gabriel Barbosa on 6/8/15.
//  Copyright (c) 2015 DGSmart. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

@objc protocol GetLocationDelegate{
    optional func didUpdateLocation(message: NSString, placemark: CLPlacemark)
}

class getLocation: NSObject, CLLocationManagerDelegate {
    
    let locationManager : CLLocationManager
    var message : String?
    var delegate:GetLocationDelegate?
    
    override init () {
        
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        message = nil
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        message = "Não foi possível determinar a localização!"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println(error.localizedDescription)
                self.locationManager.stopUpdatingLocation()
                self.message = "Não foi possível fazer a localização"
                return
            }
            
            if placemarks.count > 0 {
                let placemark = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(placemark)
                self.delegate?.didUpdateLocation!(self.message!, placemark: placemark)
            }
        })
    }
    
    func displayLocationInfo(placemark:CLPlacemark?) {
        
        if placemark != nil {
            locationManager.stopUpdatingLocation()
            //message = "\(placemark!.thoroughfare), \(placemark!.subThoroughfare) - \(placemark!.subLocality) - \(placemark!.locality)/\(placemark!.administrativeArea)"
            message = "\(placemark!.thoroughfare), \(placemark!.subThoroughfare)"
        }else{
            message = "Buscando..."
        }
        
        
    }
    
    
}

