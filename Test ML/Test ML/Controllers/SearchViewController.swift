//
//  ViewController.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 14/11/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelEmpty: UITableView!
    @IBOutlet weak var viewError: UIStackView!
    
    @IBAction func reloadSearch(_ sender: UIButton) {
        reloadSearch()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var results = [SearchData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        reloadSearch()
    }
    
    
    private func reloadSearch() {
        setVisibilityEmpty(hidden: true)
        setVisibilityNoFoundResults(hidden: true)
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in:.whitespacesAndNewlines), searchText.count > 0 {
            searchController.searchBar.resignFirstResponder()
            searchProducts(searchText: searchText)
        } else {
            DispatchQueue.main.async {
                self.searchController.searchBar.becomeFirstResponder()
            }
        }
    }
    
    private func searchProducts(searchText: String) {
        print(searchText)
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension SearchViewController {
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.setNewcolor(color: UIColor.black)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController?.searchBar.delegate = self
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.definesPresentationContext = true
    }
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = false
    }
    
    private func setVisibilityEmpty(hidden: Bool){
        viewError.isHidden = hidden
    }
    
    private func setVisibilityNoFoundResults(hidden: Bool){
        labelEmpty.isHidden = hidden
    }
    
}
