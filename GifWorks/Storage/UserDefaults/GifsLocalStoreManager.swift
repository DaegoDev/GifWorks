//
//  File.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import Foundation

protocol GifsLocalStoreManagerProtocol {
  func saveGifID(_ id: String)
  func deleteGifID(_ id: String)
  func getSavedGifs() -> [String]
}

class GifsLocalStoreManager: GifsLocalStoreManagerProtocol {
  
  func saveGifID(_ id: String) {
    var gifIDList: [String] = UserDefaults.standard.stringArray(forKey: UserDefaultsConstants.GifsStoredKey) ?? []
    if !gifIDList.contains(id) {
      gifIDList.append(id)
      UserDefaults.standard.setValue(gifIDList, forKey: UserDefaultsConstants.GifsStoredKey)
    }
  }
  
  func deleteGifID(_ id: String) {
    guard var gidIDList = UserDefaults.standard.stringArray(forKey: UserDefaultsConstants.GifsStoredKey),
          let idIndex: Int = gidIDList.firstIndex(of: id) else { return }
    gidIDList.remove(at: idIndex)
    UserDefaults.standard.setValue(gidIDList, forKey: UserDefaultsConstants.GifsStoredKey)
  }
  
  func getSavedGifs() -> [String] {
    let gifIDList = UserDefaults.standard.stringArray(forKey: UserDefaultsConstants.GifsStoredKey)
    return gifIDList ?? []
  }
}
