//
//  LibraryPresenter.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import Foundation

class LibraryPresenter: LibraryPresenterProtocol {
  // MARK: - Inyectables
  private weak var viewController: LibraryViewProtocol?
  
  // MARK: - UseCases
  private let trendingGifsUseCase: TrendingGifsUseCaseProtocol
  private let gifsUseCase: GifsUseCaseProtocol
  
  // MARK: - Models
  private var gifsModel: [LibraryGifModel] = []
  private var favoriteGifIDList: [String] = []
  
  // MARK: - Init
  init(
    viewController: LibraryViewProtocol,
    trendingGifsUseCase: TrendingGifsUseCaseProtocol,
    gifsUseCase: GifsUseCaseProtocol) {
    self.viewController = viewController
    self.trendingGifsUseCase = trendingGifsUseCase
    self.gifsUseCase = gifsUseCase
  }
  
  // MARK: - Functions
  func loadGifs() {
    updateFavoriteGifs()
    loadTrendingGifs()
  }
  
  func searchGifs(with string: String) {
    cleanData()
    gifsUseCase.search(string: string) { result in
      switch result {
      case .success(let gifs):
        self.gifsModel = gifs
        self.viewController?.reloadData()
      case .failure:
        self.viewController?.showError()
      }
    }
  }
  
  func toggleFavoriteGif(at row: Int) {
    let gifID: String = gifsModel[row].id
    gifsModel[row].isFavorite.toggle()
    if gifsModel[row].isFavorite {
      guard let gifURL = gifsModel[row].gifURL,
            let data = gifsUseCase.getDataForGif(gifURL) else { return }
      gifsUseCase.saveFavoriteGif(data, gifID: gifID)
    } else {
      gifsUseCase.deleteFavoriteGif(gifID: gifID)
    }
  }
  
  func getGifCount() -> Int {
    return gifsModel.count
  }
  
  func getGif(at row: Int) -> LibraryGifModel {
    return gifsModel[row]
  }
  
  func getGifHeight(at row: Int) -> Int {
    return gifsModel[row].height
  }
  
  // MARK: - Helpers
  private func cleanData() {
    gifsModel = []
    self.viewController?.reloadData()
  }
  
  private func loadTrendingGifs() {
    trendingGifsUseCase.getTrending { result in
      switch result {
      case .success(let gifs):
        self.gifsModel = gifs
        self.viewController?.reloadData()
      case .failure:
        self.viewController?.showError()
      }
    }
  }
  
  private func updateFavoriteGifs() {
    favoriteGifIDList = gifsUseCase.getFavoriteGifIDList()
  }
}
