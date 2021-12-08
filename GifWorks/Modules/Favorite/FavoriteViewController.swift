//
//  FavoriteViewController.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import UIKit

class FavoriteViewController: UIViewController, FavoriteViewProtocol {
  // MARK: - IBOutlets
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: - Properties
  var presenter: FavoritePresenterProtocol!
  var configurator: FavoriteConfiguratorProtocol = FavoriteConfigurator()
  let collectionViewLayout: GifCollectionViewLayout = GifCollectionViewLayout()

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionViewLayout.delegate = self
    configureCollectionView()
    configurator.configure(favoriteViewController: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.loadFavoriteGifs()
  }
  
  // MARK: - Functions
  func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = collectionViewLayout
    collectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
  }
  
  func reloadData() {
    collectionView.reloadData()
  }
  
  func deleteItem(at index: Int) {
    collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
  }
  
  func showError() {
    // TODO: - Handle show gif errors
  }
  
  // MARK: - IBActions
  @IBAction func collectionStyleChanged(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == .zero {
      collectionViewLayout.style = .grid
    } else {
      collectionViewLayout.style = .list
    }
    collectionView.collectionViewLayout.invalidateLayout()
  }
}

// MARK: - CollectionView Delegate and Datasource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.getGifCount()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell: FavoriteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as? FavoriteCollectionViewCell else { return UICollectionViewCell()}
    let gifModel = presenter.getGif(at: indexPath.item)
    cell.configure(with: gifModel)
    cell.favoriteCompletion = {
      self.presenter.deleteFavorite(with: gifModel.id)
    }
    return cell
  }
}

// MARK: - CollectionViewLayout Delegate
extension FavoriteViewController: GifCollectionViewLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexpath: IndexPath) -> CGFloat {
    return CGFloat(presenter.getGifHeight(at: indexpath.item))
  }
}
