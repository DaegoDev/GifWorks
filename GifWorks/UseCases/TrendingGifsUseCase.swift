//
//  TrendingGifsUseCase.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

class TrendingGifsUseCase {
  let networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol = NetworkService()) {
    self.networkService = networkService
  }
  
  func getTrending(completion: @escaping (Result<[GifDTO], UseCaseError>) -> Void) {
    networkService.request(TrendingGifsDataRequest()) { response in
      DispatchQueue.main.async {
        switch response {
        case .success(let giphyResponse):
          let trendingGifs: [GifDTO] = giphyResponse.data
          completion(.success(trendingGifs))
        case .failure:
          completion(.failure(.unknown))
        }
      }
    }
  }
}
