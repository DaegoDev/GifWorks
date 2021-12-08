//
//  LibraryPresenterTests.swift
//  GifWorksTests
//
//  Created by Diego Alejandro Alvarez Gallego on 8/12/21.
//

import XCTest
@testable import GifWorks

class LibraryPresenterTests: XCTestCase {
  
  var libraryViewMock: LibraryViewControllerMock!
  var gifsUseCaseMock: GifsUseCaseMock!
  var trendingUseCaseMock: TrendingGifsUseCaseMock!
  
  var sut: LibraryPresenter!
  
  override func setUp() {
    super.setUp()
    libraryViewMock = LibraryViewControllerMock()
    gifsUseCaseMock = GifsUseCaseMock()
    trendingUseCaseMock = TrendingGifsUseCaseMock()

    sut = LibraryPresenter(viewController: libraryViewMock,
                           trendingGifsUseCase: trendingUseCaseMock,
                           gifsUseCase: gifsUseCaseMock)
  }
  
  override func tearDown() {
    libraryViewMock = nil
    gifsUseCaseMock = nil
    trendingUseCaseMock = nil
    sut = nil
    super.tearDown()
  }
  
  func testLoadGifs_Empty() {
    // Given
    trendingUseCaseMock.completionExecutionType = .success
    
    // When
    sut.loadGifs()
    
    // Then
    XCTAssertTrue(libraryViewMock.calls.reloadDataCalled)
    XCTAssertEqual(sut.getGifCount(), 0)
  }
  
  func testLoadGifs_NotEmpty() {
    // Given
    let libraryGif = LibraryGifModel(
      id: "0",
      title: "Gif",
      gifURL: nil,
      height: 200,
      width: 400,
      isFavorite: false)
    trendingUseCaseMock.completionExecutionType = .success
    trendingUseCaseMock.libraryGifModel = [libraryGif]
    
    // When
    sut.loadGifs()
    
    // Then
    XCTAssertTrue(libraryViewMock.calls.reloadDataCalled)
    XCTAssertEqual(sut.getGifCount(), 1)
    XCTAssertEqual(sut.getGif(at: 0).id, libraryGif.id)
    XCTAssertFalse(sut.getGif(at: 0).isFavorite)
    XCTAssertEqual(sut.getGif(at: 0).height, libraryGif.height)
  }
  
  func testLoadGifs_HasfavoriteGif() {
    // Given
    let libraryGif = LibraryGifModel(
      id: "0",
      title: "Gif",
      gifURL: nil,
      height: 200,
      width: 400,
      isFavorite: true)
    trendingUseCaseMock.completionExecutionType = .success
    trendingUseCaseMock.libraryGifModel = [libraryGif]
    
    // When
    sut.loadGifs()
    
    // Then
    XCTAssertTrue(libraryViewMock.calls.reloadDataCalled)
    XCTAssertEqual(sut.getGifCount(), 1)
    XCTAssertEqual(sut.getGif(at: 0).id, libraryGif.id)
    XCTAssertTrue(sut.getGif(at: 0).isFavorite)
    XCTAssertEqual(sut.getGifHeight(at: 0), libraryGif.height)
  }
  
  func testLoadGifs_Error() {
    // Given
    trendingUseCaseMock.completionExecutionType = .failure
    
    // When
    sut.loadGifs()
    
    // Then
    XCTAssertTrue(libraryViewMock.calls.showErrorCalled)
    XCTAssertEqual(sut.getGifCount(), 0)
  }
  
  func testSearchGifs_Empty() {
    // Given
    let searchString: String = "cats"
    trendingUseCaseMock.completionExecutionType = .success
    
    // When
    sut.searchGifs(with: searchString)
    
    // Then
    XCTAssertTrue(libraryViewMock.calls.reloadDataCalled)
    XCTAssertEqual(sut.getGifCount(), 0)
  }
  
  func testSearchGifs_HasSearchedGifs() {
    // Given
    let searchString: String = "cats"
    let libraryGif = LibraryGifModel(
      id: searchString,
      title: "CatGif",
      gifURL: nil,
      height: 200,
      width: 400,
      isFavorite: true)
    gifsUseCaseMock.completionExecutionType = .success
    gifsUseCaseMock.libraryGifModel = [libraryGif]
    
    // When
    sut.searchGifs(with: searchString)
    
    // Then
    XCTAssertTrue(libraryViewMock.calls.reloadDataCalled)
    XCTAssertEqual(sut.getGifCount(), 1)
    XCTAssertEqual(sut.getGif(at: 0).id, libraryGif.id)
    XCTAssertTrue(sut.getGif(at: 0).isFavorite)
    XCTAssertEqual(sut.getGifHeight(at: 0), libraryGif.height)
  }
  
  func testSearchGifs_Error() {
    // Given
    let searchString: String = "cats"
    trendingUseCaseMock.completionExecutionType = .failure
    
    // When
    sut.searchGifs(with: searchString)
    
    // Then
    XCTAssertTrue(libraryViewMock.calls.showErrorCalled)
    XCTAssertEqual(sut.getGifCount(), 0)
  }
  
  func testToggleFavoriteGif_GifIsNotFavorite() {
    // Given
    let libraryGif = LibraryGifModel(
      id: "notFavorite",
      title: "CatGif",
      gifURL: URL(string: "https://media.giphy.com/media/CID2saCss34"),
      height: 200,
      width: 400,
      isFavorite: false)
    trendingUseCaseMock.completionExecutionType = .success
    trendingUseCaseMock.libraryGifModel = [libraryGif]
    sut.loadGifs()
    // When
    sut.toggleFavoriteGif(at: 0)
    
    // Then
    XCTAssertTrue(gifsUseCaseMock.calls.saveFavoriteGifCalled)
    XCTAssertTrue(sut.getGif(at: 0).isFavorite)
  }
  
  func testToggleFavoriteGif_GifIsFavorite() {
    // Given
    let libraryGif = LibraryGifModel(
      id: "notFavorite",
      title: "CatGif",
      gifURL: URL(string: "https://media.giphy.com/media/CID2saCss34"),
      height: 200,
      width: 400,
      isFavorite: true)
    trendingUseCaseMock.completionExecutionType = .success
    trendingUseCaseMock.libraryGifModel = [libraryGif]
    sut.loadGifs()
    
    // When
    sut.toggleFavoriteGif(at: 0)
    
    // Then
    XCTAssertTrue(gifsUseCaseMock.calls.deleteFavoriteGifCalled)
    XCTAssertFalse(sut.getGif(at: 0).isFavorite)
  }
}
