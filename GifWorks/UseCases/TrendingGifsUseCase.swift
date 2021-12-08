//
//  TrendingGifsUseCase.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

protocol TrendingGifsUseCaseProtocol {
  func getTrending(completion: @escaping (Result<[LibraryGifModel], UseCaseError>) -> Void)
}

class TrendingGifsUseCase: TrendingGifsUseCaseProtocol {
  // MARK: - Properties
  let networkService: NetworkServiceProtocol
  let gifsUseCase: GifsUseCaseProtocol
  
  // MARK: - Init
  init(networkService: NetworkServiceProtocol = NetworkService(),
       gifsUseCase: GifsUseCaseProtocol = GifsUseCase()) {
    self.networkService = networkService
    self.gifsUseCase = gifsUseCase
  }
  
  // MARK: - Functions
  func getTrending(completion: @escaping (Result<[LibraryGifModel], UseCaseError>) -> Void) {
    networkService.request(TrendingGifsDataRequest()) { response in
      let favoriteGifIDList = self.gifsUseCase.getFavoriteGifIDList()
      DispatchQueue.main.async {
        switch response {
        case .success(let giphyResponse):
          let trendingGifs: [GifDTO] = giphyResponse.data
          let gifs = trendingGifs.map { gifDTO in
            return LibraryGifModel(
              id: gifDTO.id,
              title: gifDTO.title,
              gifURL: URL(string: gifDTO.images.fixedHeight.url ?? String()),
              height: Int(gifDTO.images.fixedHeight.height) ?? .zero,
              width: Int(gifDTO.images.fixedHeight.width) ?? .zero,
              isFavorite: favoriteGifIDList.contains(gifDTO.id))
          }
          
          completion(.success(gifs))
        case .failure:
          completion(.failure(.unknown))
        }
      }
    }
  }
}
