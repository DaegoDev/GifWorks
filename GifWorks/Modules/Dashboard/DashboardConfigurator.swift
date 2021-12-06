//
//  DashboardConfigurator.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import UIKit

class DashboardConfigurator: DashboardConfiguratorProtocol {
  
  func configure(dashboardViewController: DashboardViewProtocol) {
    guard let libraryVC = UIStoryboard.instantiateViewController(withType: LibraryViewController.self),
          let favoriteVC = UIStoryboard.instantiateViewController(withType: FavoriteViewController.self) else { return}
    let dashboardViewModel: [DashboardViewModel] = [
      DashboardViewModel(title: "Library", viewController: libraryVC, tabIcon: UIImage(systemName: "photo.on.rectangle.angled")),
      DashboardViewModel(title: "Favorite", viewController: favoriteVC, tabIcon: UIImage(systemName: "heart"))
    ]
    dashboardViewController.configureTabs(with: dashboardViewModel)
  }
}
