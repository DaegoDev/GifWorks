//
//  FavoriteConfigurator.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import Foundation

class FavoriteConfigurator: FavoriteConfiguratorProtocol {
  func configure(favoriteViewController: FavoriteViewProtocol) {
    let presenter: FavoritePresenterProtocol = FavoritePresenter(
      viewController: favoriteViewController,
      gifsUseCase: GifsUseCase())
    favoriteViewController.presenter = presenter
  }
}
