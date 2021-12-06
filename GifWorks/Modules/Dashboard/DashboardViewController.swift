//
//  DashboardViewController.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import UIKit

class DashboardViewController: UITabBarController, DashboardViewProtocol {
  var configurator: DashboardConfiguratorProtocol = DashboardConfigurator()

  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(dashboardViewController: self)
  }
  
  func configureTabs(with model: [DashboardViewModel]) {
    let viewControllers: [UIViewController] = model.map { viewModel in
      viewModel.viewController.tabBarItem = UITabBarItem(title: "", image: viewModel.tabIcon, selectedImage: nil)
      return viewModel.viewController
    }
    
    self.viewControllers = viewControllers
  }
}

