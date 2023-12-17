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
        self.locationManagerDidChangeAuthorization(locationManager)
        self.setupFileter()
    }
        
    func setupView() {
        tableView.register(ToiletsListCellView.self, forCellReuseIdentifier: ToiletsListCellView.nameOfClass)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
            tableView.reloadData()
        case .restricted, .denied:
            manager.stopUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    private func setupFileter() {
        self.navigationItem.title = "Recherche"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrer",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(filter))
    }
    
    @objc private func filter() {
        let actionSheet = UIAlertController(title: "Personne a mobilite reduite",
                                            message: "Cherchez vous des toilettes accessible a des personne a mobilité reduite",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Oui", style: .default , handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.filterForPrm(with: "Oui")
            self.tableView.reloadData()
        }))
        actionSheet.addAction(UIAlertAction(title: "Non", style: .default , handler:{ [weak self] _ in
            guard let self = self else { return }
            self.viewModel.filterForPrm(with: "Non")
            self.tableView.reloadData()
        }))
        actionSheet.addAction(UIAlertAction(title: "Les deux", style: .default , handler:{ [weak self] _ in
            guard let self = self else { return }
            self.viewModel.filterForPrm(with: nil)
            self.tableView.reloadData()
        }))
        present(actionSheet, animated: true)
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
