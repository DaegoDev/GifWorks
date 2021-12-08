//
//  FavoritePresenterTests.swift
//  GifWorksTests
//
//  Created by Diego Alejandro Alvarez Gallego on 7/12/21.
//

import XCTest
@testable import GifWorks

class FavoritePresenterTests: XCTestCase {
  let defaultGifHeight: Int = 200
  
  var favoriteViewMock: FavoriteViewControllerMock!
  var gifsUseCaseMock: GifsUseCaseMock!
  
  var sut: FavoritePresenter!
  
  override func setUp() {
    super.setUp()
    favoriteViewMock = FavoriteViewControllerMock()
    gifsUseCaseMock = GifsUseCaseMock()
    sut = FavoritePresenter(viewController: favoriteViewMock, gifsUseCase: gifsUseCaseMock)
  }
  
  override func tearDown() {
    favoriteViewMock = nil
    gifsUseCaseMock = nil
    sut = nil
    super.tearDown()
  }
  
  func testLoadFavoriteGifs_Empty() {
    // When
    sut.loadFavoriteGifs()
    
    // Then
    XCTAssertTrue(favoriteViewMock.calls.reloadDataCalled)
    XCTAssertEqual(sut.getGifCount(), 0)
  }
  
  func testLoadFavoriteGifs_NotEmpty() {
    // Given
    gifsUseCaseMock.favoriteGifModel = [
      FavoriteGifModel(id: "0", data: Data()),
      FavoriteGifModel(id: "1", data: Data())
    ]
    
    // When
    sut.loadFavoriteGifs()
    
    // Then
    XCTAssertTrue(favoriteViewMock.calls.reloadDataCalled)
    XCTAssertEqual(sut.getGifCount(), 2)
    XCTAssertEqual(sut.getGif(at: 1).id, "1")
    XCTAssertEqual(sut.getGifHeight(at: 1), defaultGifHeight)
  }
  
  func testDeleteFavoriteGif() {
    // Given
    let gifToDelete = FavoriteGifModel(id: "deleteMe", data: Data())
    let anotherGif = FavoriteGifModel(id: "doNotDelete", data: Data())
    gifsUseCaseMock.favoriteGifModel = [gifToDelete, anotherGif]
    sut.loadFavoriteGifs()
    XCTAssertEqual(sut.getGifCount(), 2)
    
    // When
    sut.deleteFavorite(with: gifToDelete.id)
    
    // Then
    XCTAssertTrue(favoriteViewMock.calls.reloadDataCalled)
    XCTAssertTrue(favoriteViewMock.calls.deleteItemCalled)
    XCTAssertEqual(sut.getGifCount(), 1)
    XCTAssertEqual(sut.getGif(at: 0).id, anotherGif.id)
  }
}
