//
//  FavoriteCollectionViewCell.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import UIKit
import SwiftyGif

class FavoriteCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var gifImageView: UIImageView!
  
  func configure(with model: LibraryGifViewModel) {
    guard let gifURL = model.gifURL else { return }
    gifImageView.contentMode = .scaleToFill
    gifImageView.setGifFromURL(gifURL)

  }
}
