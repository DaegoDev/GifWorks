//
//  FavoriteCollectionViewCell.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
  // MARK: - IBOutlets
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var gifImageView: UIImageView!
  
  // MARK: - Properties
  var favoriteCompletion: (() -> Void)?
  
  // MARK: - Overrides
  override func prepareForReuse() {
    gifImageView.image = nil
  }
  
  // MARK: - IBActions
  @IBAction func favoriteButtonTapped(_ sender: UIButton) {
    favoriteCompletion?()
  }
  
  // MARK: - Functions
  func configure(with model: FavoriteGifModel) {
    gifImageView.contentMode = .scaleToFill
    gifImageView.loadGif(using: model.data)
  }
}
