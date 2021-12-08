//
//  FavoritePresenter.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import Foundation

class FavoritePresenter: FavoritePresenterProtocol {
  // MARK: - Constants
  private let defaultGifHeight: Int = 200
  
  // MARK: - Inyectables
  private weak var viewController: FavoriteViewProtocol?
  
  // MARK: - UseCases
  private let gifsUseCase: GifsUseCaseProtocol
    
  // MARK: - Models
  private var gifsModel: [FavoriteGifModel] = []
  private var favoriteGifs: [String] = []

  // MARK: Init
  init(
    viewController: FavoriteViewProtocol,
    gifsUseCase: GifsUseCaseProtocol = GifsUseCase()) {
    self.viewController = viewController
    self.gifsUseCase = gifsUseCase
  }
  
  // MARK: - Functions
  func loadFavoriteGifs() {
    gifsUseCase.getFavoriteGifs(completion: { gifs in
      self.gifsModel = gifs
      self.viewController?.reloadData()
    })
  }
  
  func deleteFavorite(with id: String) {
    guard let gifIndex = gifsModel.firstIndex(where: { favoriteGif in
      favoriteGif.id == id
    }) else { return }
    gifsUseCase.deleteFavoriteGif(gifID: id)
    gifsModel.remove(at: gifIndex)
    self.viewController?.deleteItem(at: gifIndex)
  }
  
  func getGifCount() -> Int {
    return gifsModel.count
  }
  
  func getGif(at row: Int) -> FavoriteGifModel {
    return gifsModel[row]
  }
  
  func getGifHeight(at row: Int) -> Int {
    return defaultGifHeight
  }
}
