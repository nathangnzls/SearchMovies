//
//  MoviesViewController.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit
import SwiftSpinner
class MoviesViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var suggestionViewHolderHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = MoviesViewModel()
    var loadMoreControl: LoadMoreControl?
    var searchedMovie = [String](repeating: "asd", count: 10)
    var index = 1
    var search = ""
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchView()
        setUpTableView()
        setUpCollectionView()
        self.navigationItem.titleView = searchController.searchBar
    }
    func setUpCollectionView(){
        let nibName = UINib(nibName: nibNames.suggestionCell, bundle: nil)
        self.collectionView.register(nibName, forCellWithReuseIdentifier: nibIds.suggestionID)
        self.collectionView.contentInsetAdjustmentBehavior = .always
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
    }
    func setUpTableView(){
        definesPresentationContext = true
        loadMoreControl = LoadMoreControl(scrollView: tableView, spacingFromLastCell: 10, indicatorHeight: 60)
        loadMoreControl?.delegate = self as LoadMoreControlDelegate
        let nibName = UINib(nibName: nibNames.movieCell, bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: nibIds.movieCellID)
    }
    func setUpSearchView(){
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = placeHolder.searchView
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
    }
    func fetchMovies(movieName: String?, pageNum: Int){
         if Reachability.isConnectedToNetwork(){
            viewModel.fetchMovies(movieName: movieName ?? "", pageNum: pageNum,{[weak self] (message, error) in
                       if error != nil{
                           self?.showAlert(title: "", message: "\(message) \(error?.localizedDescription ?? "") ", handler: { (ok) in
                           SwiftSpinner.hide()
                           })
                       }else{
                        SwiftSpinner.show(duration: 2.0, title: "\(message)",animated: false)
                        self?.tableView.reloadData()
                        self?.collectionView.reloadData()
                        self?.tableView.layoutIfNeeded()
                       }
                   })
               }else{
                   showNoInternetAlert()
               }
    }
}
extension MoviesViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {}
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SwiftSpinner.show(loaderTitle.loading)
        if (Reachability.isConnectedToNetwork()){
            self.index = 1
            self.viewModel.tempData?.removeAll()
            self.fetchMovies(movieName: searchBar.text ?? "", pageNum: index)
            self.search = searchBar.text ?? ""
            if(!self.searchedMovie.contains(searchBar.text ?? "")){
                self.searchedMovie.append(searchBar.text ?? "")
            }
        }else{
            SwiftSpinner.show(duration: 2.0, title: alertsMessage.noInternetConecction ,animated: false)
        }
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if self.searchedMovie.count != 0{
            UIView.animate(withDuration: 0.8) {
                self.suggestionViewHolderHeight.constant = 110
            }
        }
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.8) {
            self.suggestionViewHolderHeight.constant = 0
        }
    }
}
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, LoadMoreControlDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tempData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nibIds.movieCellID, for: indexPath) as? MoviesCell else { return UITableViewCell() }
        if self.viewModel.tempData?.count != 0{
            cell.results = self.viewModel.tempData?[indexPath.row]
        }
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMoreControl?.didScroll()
    }
    func loadMoreControl(didStartAnimating loadMoreControl: LoadMoreControl) {
        DispatchQueue.global(qos: .utility).async {
            for _ in 1..<2 {
                self.index += 1
                self.fetchMovies(movieName: self.search, pageNum: self.index)
                sleep(1)
            }
            DispatchQueue.main.async { [weak self] in
                self?.loadMoreControl?.stop()
            }
        }
    }
    func loadMoreControl(didStopAnimating loadMoreControl: LoadMoreControl) {
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.searchedMovie.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibIds.suggestionID, for: indexPath) as? SuggestionCollectionViewCell else { return UICollectionViewCell() }
            cell.layoutSubviews()
           DispatchQueue.main.async {
               collectionView.collectionViewLayout.invalidateLayout()
           }
            cell.searchMovies = self.searchedMovie[indexPath.row]
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let label = UILabel(frame: CGRect.zero)
            label.text = self.searchedMovie[indexPath.row]
            label.sizeToFit()
            return CGSize(width: label.frame.width+10, height: 32)
    }
}
