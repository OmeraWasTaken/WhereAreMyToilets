//
//  ToiletsListView.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 16/12/2023.
//

import CoreLocation
import UIKit

final class ToiletsListView: UITableViewController, CLLocationManagerDelegate {
    private let viewModel: ToiletsListViewModel
    private let locationManager = CLLocationManager()
    
    init(with viewModel: ToiletsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
//        self.setupLocalisation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setupView() {
        tableView.register(ToiletsListCellView.self, forCellReuseIdentifier: ToiletsListCellView.nameOfClass)
    }
    
    func setupLocalisation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension ToiletsListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToiletsListCellView.nameOfClass,
                                                               for: indexPath) as? ToiletsListCellView else {
                                                                return UITableViewCell()
                }
        let toiletInformation = viewModel.result[indexPath.item]
        print("\(viewModel.result[indexPath.item]) where index = \(indexPath.item)")
        let cellViewModel = ToiletsListCellViewModel(address: toiletInformation.fields.adress,
                                                     district: toiletInformation.fields.district,
                                                     schedule: toiletInformation.fields.schedule,
                                                     accessPrm: toiletInformation.fields.accessPrm,
                                                     localisation: toiletInformation.fields.coordinates,
                                                     currentLocalisation: locationManager.location)
        cell.setupCell(with: cellViewModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
