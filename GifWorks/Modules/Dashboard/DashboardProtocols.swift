//
//  DashboardProtocols.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import UIKit

protocol DashboardViewProtocol {
  func configureTabs(with model: [DashboardViewModel])
}

protocol DashboardConfiguratorProtocol {
  func configure(dashboardViewController: DashboardViewProtocol)
}
