//
//  FavoriteViewControllerMock.swift
//  GifWorksTests
//
//  Created by Diego Alejandro Alvarez Gallego on 7/12/21.
//

import UIKit
@testable import GifWorks

class FavoriteViewControllerMock: UIViewController, FavoriteViewProtocol {
  struct Calls {
    var reloadDataCalled = false
    var deleteItemCalled = false
    var showErrorCalled = false
  }
  
  var presenter: FavoritePresenterProtocol!
  var calls: Calls = Calls()
  
  func reloadData() {
    calls.reloadDataCalled = true
  }
  
  func deleteItem(at index: Int) {
    calls.deleteItemCalled = true
  }
  
  func showError() {
    calls.showErrorCalled = true
  }
}
