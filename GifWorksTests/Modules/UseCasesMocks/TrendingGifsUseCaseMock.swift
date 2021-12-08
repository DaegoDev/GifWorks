//
//  TrendingGifsUseCaseMock.swift
//  GifWorksTests
//
//  Created by Diego Alejandro Alvarez Gallego on 8/12/21.
//

import Foundation
@testable import GifWorks

class TrendingGifsUseCaseMock: TrendingGifsUseCaseProtocol {
  struct Calls {
    var getTrending = false
  }
  
  var calls: Calls = Calls()
  var completionExecutionType: CompletionExecutionType = .none
  var libraryGifModel: [LibraryGifModel] = []

  func getTrending(completion: @escaping (Result<[LibraryGifModel], UseCaseError>) -> Void) {
    completionExecutionType == .success ? completion(.success(libraryGifModel)) : completion(.failure(.unknown))
    calls.getTrending = true
  }
}
