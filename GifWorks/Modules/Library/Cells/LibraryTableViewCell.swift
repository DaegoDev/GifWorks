//
//  LibraryTablewViewCell.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 5/12/21.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
  // MARK: - IBOutlets
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var gifImageView: UIImageView!
  
  // MARK: - Constants
  private let favoriteImageName: String = "heart.fill"
  private let notFavoriteImageName: String = "heart"
  
  // MARK: - Properties
  private var model: LibraryGifModel?
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
  func configure(with model: LibraryGifModel) {
    guard let gifURL = model.gifURL else { return }
    gifImageView.loadGif(using: gifURL)
    gifImageView.contentMode = .scaleToFill
    setFavoriteImage(isSelected: model.isFavorite)
  }
  
  func setFavoriteImage(isSelected: Bool) {
    favoriteButton.setBackgroundImage(UIImage(systemName: isSelected ? favoriteImageName : notFavoriteImageName), for: .normal)
  }
}
