//
//  ViewController.swift
//  Maps
//
//  Created by ben on 29/11/2014.
//  Copyright (c) 2014 Ben Chamla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


// to get location don't forget to go in supportingfiles/Info.plest and clic on the little "+". then add "NSLocationWhenInUseUsageDescription".

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    
    var manager = CLLocationManager()
    @IBOutlet weak var myMap: MKMapView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // core location
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        //37.777472, -122.417185

      
        var latitude: CLLocationDegrees = 37.777472
        var longitude: CLLocationDegrees = -122.417185
        var latDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
       
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)
        
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = "Ben's Home"
        
        annotation.subtitle = "Home sweet home..."
        
        myMap.addAnnotation(annotation)
        
        var UserPress = UILongPressGestureRecognizer(target: self, action: "action:")
        
        UserPress.minimumPressDuration = 2.0
        
        myMap.addGestureRecognizer(UserPress)
        
    }
    
    func action(gestureRecognizer: UIGestureRecognizer){
        
        var touchPoint = gestureRecognizer.locationInView(self.myMap)
        
        var newCoordinate:  CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
        var newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "New Point"
        newAnnotation.subtitle = "yehe, I made it..."
        myMap.addAnnotation(newAnnotation)
        
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation: CLLocation = locations[0] as CLLocation
     
        
        var latitude: CLLocationDegrees = userLocation.coordinate.latitude
        var longitude: CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta: CLLocationDegrees = 0.01
        var longDelta: CLLocationDegrees = 0.01
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        myMap.setRegion(region, animated: true)

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

