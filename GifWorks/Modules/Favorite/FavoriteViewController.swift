//
//  FavoriteViewController.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import UIKit

class FavoriteViewController: UIViewController, FavoriteViewProtocol {
  var presenter: FavoritePresenterProtocol!
  var configurator: FavoriteConfiguratorProtocol = FavoriteConfigurator()
  
  let collectionViewLayout: GifCollectionViewLayout = GifCollectionViewLayout()

  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionViewLayout.delegate = self
    configureCollectionView()
    configurator.configure(favoriteViewController: self)
    self.presenter.viewDidLoad()
  }
  
  func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = collectionViewLayout
    collectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
  }
  
  func reloadData() {
    collectionView.reloadData()
  }
  
  func showError() {
    
  }
  
  @IBAction func collectionStyleChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      collectionViewLayout.style = .grid
    } else {
      collectionViewLayout.style = .list
    }
    collectionView.collectionViewLayout.invalidateLayout()
  }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.getGifCount()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell: FavoriteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as? FavoriteCollectionViewCell else { return UICollectionViewCell()}
    cell.configure(with: presenter.getGif(at: indexPath.row))
    return cell
  }
}

extension FavoriteViewController: GifCollectionViewLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexpath: IndexPath) -> CGFloat {
    return CGFloat(presenter.getGif(at: indexpath.item).height)
  }
}
