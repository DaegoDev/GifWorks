//
//  LibraryViewControllerMock.swift
//  GifWorksTests
//
//  Created by Diego Alejandro Alvarez Gallego on 8/12/21.
//

import UIKit
@testable import GifWorks

class LibraryViewControllerMock: UIViewController, LibraryViewProtocol {
  struct Calls {
    var reloadDataCalled = false
    var showErrorCalled = false
  }
  
  var presenter: LibraryPresenterProtocol!
  var calls: Calls = Calls()

  func reloadData() {
    calls.reloadDataCalled = true
  }
  
  func showError() {
    calls.showErrorCalled = true
  }
}
