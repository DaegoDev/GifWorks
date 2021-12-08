//
//  LibraryProtocols.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

protocol LibraryConfiguratorProtocol {
  func configure(libraryViewController: LibraryViewProtocol)
}

protocol LibraryViewProtocol: AnyObject {
  var presenter: LibraryPresenterProtocol! { get set }
  func reloadData()
  func showError()
}

protocol LibraryPresenterProtocol {
  func loadGifs()
  func searchGifs(with string: String)
  func getGifCount() -> Int
  func getGif(at row: Int) -> LibraryGifModel
  func getGifHeight(at row: Int) -> Int
  func toggleFavoriteGif(at row: Int)
}
