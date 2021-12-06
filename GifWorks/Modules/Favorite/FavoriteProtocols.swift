//
//  FavoriteProtocols.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import Foundation

protocol FavoriteConfiguratorProtocol {
  func configure(favoriteViewController: FavoriteViewProtocol)
}

protocol FavoriteViewProtocol: AnyObject {
  var presenter: FavoritePresenterProtocol! { get set }
  func reloadData()
  func showError()
}

protocol FavoritePresenterProtocol {
  func viewDidLoad()
  func getGifCount() -> Int
  func getGif(at row: Int) -> LibraryGifViewModel
  func getGifHeight(at row: Int) -> Int
}
