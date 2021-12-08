//
//  LibraryViewController.swift
//  GifWorks
//
//  Created by Diego Alejandro Alvarez Gallego on 4/12/21.
//

import UIKit

class LibraryViewController: UIViewController, LibraryViewProtocol {
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  // MARK: - Properties
  var presenter: LibraryPresenterProtocol!
  var configurator: LibraryConfiguratorProtocol = LibraryConfigurator()
  
  // MARK - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    searchBar.delegate = self
    configurator.configure(libraryViewController: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.loadGifs()
  }
  
  // MARK: - Overrides
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.searchBar.endEditing(true)
  }
  
  // MARK - Functions
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "LibraryTableViewCell", bundle: .main), forCellReuseIdentifier: "LibraryTableViewCell")
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
  }
  
  func reloadData() {
    tableView.reloadData()
  }
  
  func showError() {
      
  }
}

// MARK: - TableView Delegate and Datasource
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.getGifCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell: LibraryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as? LibraryTableViewCell else { return UITableViewCell()}
    let gifModel = self.presenter.getGif(at: indexPath.row)
    cell.configure(with: gifModel)
    cell.favoriteCompletion = {
      self.presenter.toggleFavoriteGif(at: indexPath.row)
      cell.setFavoriteImage(isSelected: self.presenter.getGif(at: indexPath.row).isFavorite)
    }
    return cell
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(presenter.getGifHeight(at: indexPath.row))
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.searchBar.endEditing(true)
  }
}

// MARK: - Searchbar Delegate
extension LibraryViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.presenter.searchGifs(with: searchBar.text ?? "")
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}
