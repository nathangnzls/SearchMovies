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

    @IBOutlet weak var tableView: UITableView!
    var viewModel = MoviesViewModel()
    var loadMoreControl: LoadMoreControl?
    var tempData = [Results]()
    var index = 1
    var search = ""
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        setUpSearchView()
        setUpTableView()
        self.navigationItem.titleView = searchController.searchBar
    }
    func setUpTableView(){
        loadMoreControl = LoadMoreControl(scrollView: tableView, spacingFromLastCell: 10, indicatorHeight: 60)
        loadMoreControl?.delegate = self as! LoadMoreControlDelegate
        let nibName = UINib(nibName: "MovieCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "MoviesCell")
    }
    func setUpSearchView(){
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
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
                        self?.tempData += self?.viewModel.tempModel ?? []
                        print("arrrs: \(self?.tempData.count)")
                        self?.tableView.reloadData()
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
        SwiftSpinner.show("Loading contents...")
        if (Reachability.isConnectedToNetwork()){
            self.index = 1
            self.tempData.removeAll()
            self.fetchMovies(movieName: searchBar.text ?? "", pageNum: index)
            self.search = searchBar.text ?? ""
        }else{
            SwiftSpinner.show(duration: 2.0, title: "Please Check your Internet Connection and try again",animated: false)
        }
    }
}
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tempData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as? MoviesCell else { return UITableViewCell() }
        cell.results = self.tempData[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row+1 == viewModel.moviesCount(){
//            index += 1
//           // self.fetchMovies(movieName: search, pageNum: index)
//            print("search: \(search) index: \(index)")
//            self.tableView.reloadData()
//            self.tableView.layoutIfNeeded()
//        }
//    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//         if indexPath.row+1 == viewModel.moviesCount(){
//           //
//                    index += 1
//            print("search: \(search) index: \(index) rowCount: \(self.viewModel.moviesCount())")
//                    tableView.scrollToRow(at: IndexPath.init(row: viewModel.moviesCount()-2, section: 0), at: .none, animated: true)
//
//                    //self.fetchMovies(movieName: search, pageNum: index)
//                    //self.tableView.reloadData()
//                    //self.tableView.layoutIfNeeded()
//          //  tableView.endUpdates()
//          }
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMoreControl?.didScroll()
        
    }
}
extension MoviesViewController: LoadMoreControlDelegate {
    func loadMoreControl(didStartAnimating loadMoreControl: LoadMoreControl) {
        DispatchQueue.global(qos: .utility).async {
            for i in 1..<2 {
                self.index += 1
                self.fetchMovies(movieName: self.search, pageNum: self.index)
                sleep(1)
            }
            DispatchQueue.main.async { [weak self] in
                self?.loadMoreControl?.stop()
            }
        }
        //loadMoreControl.stop()
    }

    func loadMoreControl(didStopAnimating loadMoreControl: LoadMoreControl) {
    }
}
