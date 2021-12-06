//
//  SearchGifsDataRequest.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

class SearchGifsDataRequest: DataRequest {
  typealias Response = GiphyResponseDTO<[GifDTO]>
  
  private let searchString: String
  
  var url: String {
    let baseURL: String = PlistUtils.getPlist(name: ConfigurationConstants.configurationPlist)?[ConfigurationConstants.baseGiphyURL] ?? String()
    let path: String = "/gifs/search"
    return baseURL + path
  }
  
  var queryItems: [String : String] {
    return ["q": searchString]
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  init(searchString: String) {
    self.searchString = searchString
  }
}
