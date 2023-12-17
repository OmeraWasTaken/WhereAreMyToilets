//
//  MapViewController.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import UIKit
import MapKit

final class MapViewController: UIViewController, MKMapViewDelegate {
    private let viewModel: MapViewModel
    private lazy var mapView : MKMapView = {
        let map = MKMapView()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.866667,
                                                                       longitude: 2.333333),
                                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        map.showsUserLocation = true
        map.overrideUserInterfaceStyle = .dark
        map.translatesAutoresizingMaskIntoConstraints = false
        map.setRegion(region, animated: false)
        return map
    }()
    
    init(with viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        mapView.delegate = self
        addPins()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupMap() {
        self.view.addSubview(self.mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func addPins() {
        for coordinate in viewModel.getCoordinates() {
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude,
                                                    longitude: coordinate.coordinate.longitude)
            mapView.addAnnotation(pin)
        }
    }
}
