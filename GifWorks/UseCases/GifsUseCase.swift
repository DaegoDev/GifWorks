//
//  GifsUseCase.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

protocol GifsUseCaseProtocol {
  func search(string: String, completion: @escaping (Result<[LibraryGifModel], UseCaseError>) -> Void)
  func getFavoriteGifIDList() -> [String]
  func getFavoriteGifs(completion: @escaping ([FavoriteGifModel]) -> Void)
  func saveFavoriteGif(_ data: Data, gifID: String)
  func deleteFavoriteGif(gifID: String)
  func getDataForGif(_ url: URL) -> Data?
}

class GifsUseCase: GifsUseCaseProtocol {
  // MARK: - Properties
  private let networkService: NetworkServiceProtocol
  private let fileSystemStorageManager: FileSystemStorageDataManagerProtocol
  private let gifsLocalStoreManager: GifsLocalStoreManagerProtocol
  
  // MARK: - Init
  init(networkService: NetworkServiceProtocol = NetworkService(),
       fileSystemStorageManager: FileSystemStorageDataManagerProtocol = FileSystemStorageDataManager(),
       gifsLocalStoreManager: GifsLocalStoreManagerProtocol = GifsLocalStoreManager()) {
    self.networkService = networkService
    self.fileSystemStorageManager = fileSystemStorageManager
    self.gifsLocalStoreManager = gifsLocalStoreManager
  }
  
  // MARK: - Functions
  func search(string: String, completion: @escaping (Result<[LibraryGifModel], UseCaseError>) -> Void) {
    networkService.request(SearchGifsDataRequest(searchString: string)) { response in
      let favoriteGifIDList = self.getFavoriteGifIDList()
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
  
  func getFavoriteGifIDList() -> [String] {
    return gifsLocalStoreManager.getSavedGifs()
  }
  
  func getFavoriteGifs(completion: @escaping ([FavoriteGifModel]) -> Void) {
    let favoriteGifIDList = getFavoriteGifIDList()
    var gifs: [FavoriteGifModel] = []

    let group = DispatchGroup()
    
    for favoriteGif in favoriteGifIDList {
      group.enter()
      fileSystemStorageManager.retrieveFile(
        filename: favoriteGif,
        fileExtension: FileSystemStorageConstants.gifExtension) { data in
        guard let data = data else {
          group.leave()
          return
        }
        let favoriteGif = FavoriteGifModel(id: favoriteGif, data: data)
        gifs.append(favoriteGif)
        group.leave()
      }
    }
    
    group.notify(queue: .main) {
      completion(gifs)
    }
  }
  
  func saveFavoriteGif(_ data: Data, gifID: String) {
    gifsLocalStoreManager.saveGifID(gifID)
    fileSystemStorageManager.saveFile(
      data,
      filename: gifID,
      fileExtension: FileSystemStorageConstants.gifExtension,
      completion: nil)
  }
  
  func deleteFavoriteGif(gifID: String) {
    gifsLocalStoreManager.deleteGifID(gifID)
    fileSystemStorageManager.deleteFile(
      filename: gifID,
      fileExtension: FileSystemStorageConstants.gifExtension,
      completion: nil)
  }
  
  func getDataForGif(_ url: URL) -> Data? {
    return try? Data(contentsOf: url)
  }
}
