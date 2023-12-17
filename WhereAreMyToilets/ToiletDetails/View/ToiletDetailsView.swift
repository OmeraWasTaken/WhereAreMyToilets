//
//  ToiletDetailsView.swift
//  WhereAreMyToilets
//
//  Created by Quentin Richard on 17/12/2023.
//

import UIKit

final class ToiletDetailsView: UIViewController {
    private let viewModel: ToiletDetailsViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.viewModel.title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = self.viewModel.description
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = self.viewModel.getAddress()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.text = self.viewModel.getSchedule()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accessPrmLabel: UILabel = {
        let label = UILabel()
        label.text = self.viewModel.getAccessPrm()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(with viewModel: ToiletDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupTitleLabel()
        setupDescirptionLabel()
        setupAdressLabel()
        setupScheduleLabel()
        setupAccessPrmLabel()
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

        ])
    }
    
    private func setupDescirptionLabel() {
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

        ])
    }
    
    private func setupAdressLabel() {
        view.addSubview(adressLabel)
        NSLayoutConstraint.activate([
            adressLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            adressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            adressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

        ])
    }
    
    private func setupScheduleLabel() {
        view.addSubview(scheduleLabel)
        NSLayoutConstraint.activate([
            scheduleLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 16),
            scheduleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scheduleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupAccessPrmLabel() {
        view.addSubview(accessPrmLabel)
        NSLayoutConstraint.activate([
            accessPrmLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 16),
            accessPrmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            accessPrmLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }

}
