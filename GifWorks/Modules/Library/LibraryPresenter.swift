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
  private let trendingGifsUseCase: TrendingGifsUseCase
  private let gifsUseCase: GifsUseCase
  
  // MARK: - Models
  private var gifsModel: [LibraryGifViewModel] = []
  
  // MARK: Init
  init(
    viewController: LibraryViewProtocol,
    trendingGifsUseCase: TrendingGifsUseCase,
    gifsUseCase: GifsUseCase) {
    self.viewController = viewController
    self.trendingGifsUseCase = trendingGifsUseCase
    self.gifsUseCase = gifsUseCase
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
  
  func searchGifs(with string: String) {
    gifsModel = []
    self.viewController?.reloadData()
    gifsUseCase.search(string: string) { result in
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
  
  func toggleFavoriteGif(at row: Int) {
    gifsModel[row].isFavorite.toggle()
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
