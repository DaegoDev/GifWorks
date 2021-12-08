//
//  GifsUseCaseMock.swift
//  GifWorksTests
//
//  Created by Diego Alejandro Alvarez Gallego on 8/12/21.
//

import Foundation
@testable import GifWorks

class GifsUseCaseMock: GifsUseCaseProtocol {
  struct Calls {
    var searchCalled = false
    var getFavoriteGifIDListCalled = false
    var getFavoriteGifsCalled = false
    var saveFavoriteGifCalled = false
    var deleteFavoriteGifCalled = false
  }
  
  var calls : Calls = Calls()
  var completionExecutionType: CompletionExecutionType = .none
  var libraryGifModel: [LibraryGifModel] = []
  var favoriteGifModel: [FavoriteGifModel] = []
  var favoriteGifsIDList: [String] = []

  func search(string: String, completion: @escaping (Result<[LibraryGifModel], UseCaseError>) -> Void) {
    completionExecutionType == .success ? completion(.success(libraryGifModel)) : completion(.failure(.unknown))
    calls.searchCalled = true
  }
  
  func getFavoriteGifIDList() -> [String] {
    calls.getFavoriteGifIDListCalled = true
    return favoriteGifsIDList
  }
  
  func getFavoriteGifs(completion: @escaping ([FavoriteGifModel]) -> Void) {
    completion(favoriteGifModel)
    calls.getFavoriteGifsCalled = true
  }
  
  func saveFavoriteGif(_ data: Data, gifID: String) {
    calls.saveFavoriteGifCalled = true
  }
  
  func deleteFavoriteGif(gifID: String) {
    calls.deleteFavoriteGifCalled = true
  }
  
  func getDataForGif(_ url: URL) -> Data? {
    return Data()
  }
}
