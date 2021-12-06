//
//  GiphyResponseDTO.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

struct GiphyResponseDTO<T: Codable>: Codable {
  let data: T
  let pagination: GiphyPaginationDTO
}

struct GiphyPaginationDTO: Codable {
  let offset: Int
  let totalCount: Int
  let count: Int
  
  enum CodingKeys: String, CodingKey {
    case offset
    case totalCount = "total_count"
    case count
  }
}
