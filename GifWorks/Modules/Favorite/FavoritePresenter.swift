//
//  FavoritePresenter.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import Foundation

class FavoritePresenter: FavoritePresenterProtocol {
  // MARK: - Inyectables
  private weak var viewController: FavoriteViewProtocol?
  
  // MARK: - Models
  private var gifsModel: [LibraryGifViewModel] = []

  // MARK: - UseCases
  private let trendingGifsUseCase: TrendingGifsUseCase = TrendingGifsUseCase()
  private let gifsUseCase: GifsUseCase = GifsUseCase()
    
  // MARK: Init
  init(
    viewController: FavoriteViewProtocol,
    gifsUseCase: GifsUseCase) {
    self.viewController = viewController
  }
  
  func viewDidLoad() {
    trendingGifsUseCase.getTrending { result in
      switch result {
      case .success(let gifs):
        self.gifsModel = gifs.map({ gifDTO in
          return LibraryGifViewModel(
            title: gifDTO.title,
            gifURL: URL(string: gifDTO.images.fixedHeight.url ?? String()),
            height: Int(gifDTO.images.fixedHeight.height) ?? .zero,
            width: Int(gifDTO.images.fixedHeight.width) ?? .zero,
            isFavorite: false)
        })
        self.viewController?.reloadData()
      case .failure:
        self.viewController?.showError()
      }
    }
  }
  
  func getGifCount() -> Int {
    return gifsModel.count
  }
  
  func getGif(at row: Int) -> LibraryGifViewModel {
    return gifsModel[row]
  }
  
  func getGifHeight(at row: Int) -> Int {
    return gifsModel[row].height
  }
}
