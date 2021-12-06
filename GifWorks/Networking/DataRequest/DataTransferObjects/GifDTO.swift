//
//  GifDTO.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import Foundation

struct GifDTO: Codable {
  let id: String
  let title: String
  let rating: String
  let embedURL: String
  let bitlyURL: String
  let type: String
  let slug: String
  let url: String
  let images: ImageContainerDTO
  
  enum CodingKeys: String, CodingKey {
    case title, rating, type, id, slug, url, images
    case embedURL = "embed_url"
    case bitlyURL = "bitly_url"
  }
}

struct ImageContainerDTO: Codable {
  let original: ImageDTO
  let fixedHeight: ImageDTO
  
  enum CodingKeys: String, CodingKey {
    case original
    case fixedHeight = "fixed_height"
  }
}

struct ImageDTO: Codable {
  let url: String?
  let width: String
  let height: String
  let frames: String?
  let mp4: String?
  let webp: String?
}
