//
//  LibraryConfigurator.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

class LibraryConfigurator: LibraryConfiguratorProtocol {
  func configure(libraryViewController: LibraryViewProtocol) {
    let presenter: LibraryPresenterProtocol = LibraryPresenter(
      viewController: libraryViewController,
      trendingGifsUseCase: TrendingGifsUseCase(),
      gifsUseCase: GifsUseCase())
    libraryViewController.presenter = presenter
  }
}
