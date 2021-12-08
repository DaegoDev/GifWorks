//
//  UIImageView+extensions.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 6/12/21.
//

import UIKit

extension UIImageView {
  func loadGif(using url: URL) {
    let loader: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    startLoader(loader: loader)
    DispatchQueue.global().async {
      let gifImage: UIImage? = UIImage.loadGif(with: url)
      DispatchQueue.main.async {
        self.image = gifImage
        self.stopLoader(loader: loader)
      }
    }
  }
  
  func loadGif(using data: Data) {
    let loader: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    startLoader(loader: loader)
    DispatchQueue.global().async {
      let gifImage: UIImage? = UIImage.loadGif(with: data)
      DispatchQueue.main.async {
        self.image = gifImage
        self.stopLoader(loader: loader)
      }
    }
  }
  
  private func startLoader(loader: UIActivityIndicatorView) {
    loader.translatesAutoresizingMaskIntoConstraints = false
    loader.startAnimating()
    self.addSubview(loader)
    
    loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
  
  private func stopLoader(loader: UIActivityIndicatorView) {
    loader.stopAnimating()
    loader.removeFromSuperview()
  }
}
