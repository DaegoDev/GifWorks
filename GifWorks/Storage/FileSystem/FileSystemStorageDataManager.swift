//
//  GifsFileStoreManager.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import Foundation

protocol FileSystemStorageDataManagerProtocol {
  func saveFile(_ data: Data, filename: String, fileExtension: String, completion: ((_ fileSaved: Bool) -> Void)?)
  func retrieveFile(filename: String, fileExtension: String , completion: @escaping ((Data?) -> Void))
  func deleteFile(filename: String, fileExtension: String , completion: ((Bool) -> Void)?)
}

class FileSystemStorageDataManager: FileSystemStorageDataManagerProtocol {
  func saveFile(_ data: Data, filename: String, fileExtension: String, completion: ((_ fileSaved: Bool) -> Void)?) {
    guard let fileURL = getFilePath(for: filename, with: fileExtension) else {
      completion?(false)
      return
    }
    
    DispatchQueue.global(qos: .background).async {
      do {
        try data.write(to: fileURL, options: .atomic)
        DispatchQueue.main.async {
          completion?(true)
        }
      } catch {
        print(error)
        completion?(false)
      }
    }
  }
  
  func retrieveFile(filename: String, fileExtension: String , completion: @escaping ((Data?) -> Void)) {
    guard let fileURL = getFilePath(for: filename, with: fileExtension) else {
      completion(nil)
      return
    }
    DispatchQueue.main.async {
      completion(FileManager.default.contents(atPath: fileURL.path))
    }
  }
  
  func deleteFile(filename: String, fileExtension: String , completion: ((Bool) -> Void)?) {
    guard let fileURL = getFilePath(for: filename, with: fileExtension) else {
      completion?(false)
      return
    }
    do {
      try FileManager.default.removeItem(at: fileURL)
      completion?(true)
    } catch {
      print(error)
      completion?(false)
    }
  }

  private func getFilePath(for filename: String, with fileExtension: String) -> URL? {
    do {
      let folderURL = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true)
      
      return folderURL.appendingPathComponent(filename + fileExtension)
    } catch {
      print(error)
      return nil
    }
  }
}
