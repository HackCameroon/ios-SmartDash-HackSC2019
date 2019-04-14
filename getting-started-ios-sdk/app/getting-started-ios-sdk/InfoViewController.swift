//
//  MapViewController.swift
//  getting-started-ios-sdk
//
//  Created by Kevin Li on 4/13/19.
//  Copyright © 2019 Smartcar. All rights reserved.
//

import UIKit
import MapKit
import Firebase

final class IncidentAnnotation: NSObject, MKAnnotation{
	var coordinate: CLLocationCoordinate2D
	var title: String?
	var subtitle: String?
	
	init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
		self.coordinate = coordinate
		self.title = title
		self.subtitle = subtitle
		
		super.init()
	}
	
	var region: MKCoordinateRegion{
		let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
		return MKCoordinateRegion(center: coordinate, span: span)
	}
}
class InfoViewController: UIViewController {
	
	@IBOutlet weak var mapView: MKMapView!
	var ref: DatabaseReference!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
		
		ref = Database.database().reference()
		// TO READ FROM FIREBASE
		ref.child("locations").observeSingleEvent(of: .value, with: { (snapshot) in
			for child in snapshot.children.allObjects as! [DataSnapshot] {
				let dict = child.value as? [String : AnyObject] ?? [:]
				let age = dict["age"] ?? "" as AnyObject
				let latitude = dict["data"]?["latitude"] as! Double
				let longitude = dict["data"]?["longitude"] as! Double
				let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
				let annotation = IncidentAnnotation(coordinate: coord, title: (age as! String), subtitle: "incident")
				self.mapView.addAnnotation(annotation)
			}
			
		}) { (error) in
			print(error.localizedDescription)
		}
		
		
		//		let mitCoordinate = CLLocationCoordinate2D(latitude: 34.0224, longitude: -118.2851)
		//		let mitAnnotation = IncidentAnnotation(coordinate: mitCoordinate, title: "USC", subtitle: "shit on my ass who am i where do i belong what the fuck am i doing")
		//		mapView.addAnnotation(mitAnnotation)
		//		mapView.setRegion(mitAnnotation.region, animated: true)
	}
	
}

extension InfoViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if let incidentAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
			incidentAnnotationView.animatesWhenAdded = true
			incidentAnnotationView.titleVisibility = .adaptive
			incidentAnnotationView.subtitleVisibility = .adaptive
			
			return incidentAnnotationView
		}
		return nil
	}
}
