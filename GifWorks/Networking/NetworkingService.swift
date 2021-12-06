//
//  NetworkingService.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

protocol NetworkServiceProtocol {
  func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
  func request<Request>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) where Request : DataRequest {
    guard var urlComponents: URLComponents = URLComponents(string: request.url) else {
      let error = NSError(domain: "",code: 404, userInfo: nil)
      return completion(.failure(error))
    }
    
    var queryItems: [URLQueryItem] = []
    
    request.queryItems.forEach {
      let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
      urlComponents.queryItems?.append(urlQueryItem)
      queryItems.append(urlQueryItem)
    }
    
    let configurationPlist = PlistUtils.getPlist(name: ConfigurationConstants.configurationPlist)
    let apiKeyQueryItem = URLQueryItem(name: NetworkingConstants.apiKey, value: configurationPlist?[ConfigurationConstants.apiKey] ?? String())
    queryItems.append(apiKeyQueryItem)
    urlComponents.queryItems?.append(apiKeyQueryItem)
    urlComponents.queryItems = queryItems
    
    guard let url: URL = urlComponents.url else {
      let error = NSError(domain: "", code: 404, userInfo: nil)
      return completion(.failure(error))
    }
    
    var urlRequest: URLRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.headers
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      if let error = error { return completion(.failure(error)) }
      guard let data = data,
            let response = response as? HTTPURLResponse,
            200..<300 ~= response.statusCode  else {
        return completion(.failure(NSError()))
      }
      
      do {
        try completion(.success(request.decode(data)))
      } catch let error as NSError {
        completion(.failure(error))
      }
    }.resume()
  }
}
