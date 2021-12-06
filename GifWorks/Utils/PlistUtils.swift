//
//  PlistUtils.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

class PlistUtils {
  class func getPlist(name: String) -> [String: String]? {
    guard let path = Bundle.main.path(forResource: name, ofType: "plist") else { return nil }
    let url: URL = URL(fileURLWithPath: path)
    guard let data = try? Data(contentsOf: url) else { return nil }
    return try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String]
  }
}
