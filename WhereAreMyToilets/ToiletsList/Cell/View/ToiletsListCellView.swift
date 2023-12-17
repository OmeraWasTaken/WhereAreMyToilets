//
//  ToiletsListCellView.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import UIKit

final class ToiletsListCellView: UITableViewCell {
    private var viewModel: ToiletsListCellViewModel?
    
    private lazy var addressLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scheduleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accessPrmLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var distanceLabel : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    func setupCell(with viewModel: ToiletsListCellViewModel) {
        self.viewModel = viewModel
        self.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addressLabel.text = nil
        scheduleLabel.text = nil
        accessPrmLabel.text = nil
        distanceLabel.text = nil
    }

    
    private func setupView() {
        setupAddressLabel()
        setupScheduleLabel()
        setupAccessPrmLabel()
        setupDistanceLabel()
    }
    
    private func setupAddressLabel() {
        self.addSubview(addressLabel)
        addressLabel.text = "Adresse: " + (viewModel?.getAddress() ?? "")
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupScheduleLabel() {
        self.addSubview(scheduleLabel)
        scheduleLabel.text = "Horaire: " + (viewModel?.getSchedule() ?? "")
        NSLayoutConstraint.activate([
            scheduleLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            scheduleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            scheduleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupAccessPrmLabel() {
        self.addSubview(accessPrmLabel)
        accessPrmLabel.text = "Accée personne a mobilité reduite: " + (viewModel?.accessPrm ?? "Nous n'avons pas l'information")
        NSLayoutConstraint.activate([
            accessPrmLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 8),
            accessPrmLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            accessPrmLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupDistanceLabel() {
        self.addSubview(distanceLabel)
        distanceLabel.text = "Distance: " + (self.viewModel?.getLocalisation() ?? "")
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: accessPrmLabel.bottomAnchor, constant: 8),
            distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
