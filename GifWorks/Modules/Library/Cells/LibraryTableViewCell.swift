//
//  LibraryTablewViewCell.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import UIKit
import SwiftyGif

class LibraryTableViewCell: UITableViewCell {
  private let favoriteImageName: String = "heart.fill"
  private let notFavoriteImageName: String = "heart"
  
  private var model: LibraryGifViewModel?
  var favoriteCompletion: (() -> Void)?
  
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var gifImageView: UIImageView!
  
  @IBAction func favoriteButtonTapped(_ sender: UIButton) {
    favoriteCompletion?()
    setFavoriteImage(isSelected: !(model?.isFavorite ?? true))
    model?.isFavorite.toggle()
  }
  
  func configure(with model: LibraryGifViewModel) {
    guard let gifURL = model.gifURL else { return }
    let data = NSData(contentsOf: gifURL)
    gifImageView.contentMode = .scaleToFill
    gifImageView.setGifFromURL(gifURL)
    setFavoriteImage(isSelected: model.isFavorite)
  }
  
  func setFavoriteImage(isSelected: Bool) {
    favoriteButton.setImage(UIImage(systemName: isSelected ? favoriteImageName : notFavoriteImageName), for: .normal)
  }
}
