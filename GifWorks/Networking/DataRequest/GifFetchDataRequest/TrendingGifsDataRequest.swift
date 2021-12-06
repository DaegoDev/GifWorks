//
//  GifFetchDataRequest.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

class TrendingGifsDataRequest: DataRequest {
  typealias Response = GiphyResponseDTO<[GifDTO]>
  
  var url: String {
    let baseURL: String = PlistUtils.getPlist(name: ConfigurationConstants.configurationPlist)?[ConfigurationConstants.baseGiphyURL] ?? String()
    let path: String = "/gifs/trending"
    return baseURL + path
  }
  
  var method: HTTPMethod {
    return .get
  }
}
