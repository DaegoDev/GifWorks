//
//  DataRequest.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

protocol DataRequest {
  associatedtype Response
  
  var url: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String] { get }
  var queryItems: [String: String] { get }
  
  func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
  func decode(_ data: Data) throws -> Response {
    let decoder: JSONDecoder = JSONDecoder()
    return try decoder.decode(Response.self, from: data)
  }
}

extension DataRequest {
  var headers: [String: String] {
    return [:]
  }
  
  var queryItems: [String: String] {
    return [:]
  }
}
