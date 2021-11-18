//
//  Test_MLTests.swift
//  Test MLTests
//
//  Created by Juan Esteban Pelaez on 14/11/21.
//

import XCTest
@testable import Test_ML

class SearchViewControllerTests: XCTestCase {

    private var sut: SearchViewController!
    private var viewModel: MockSearchViewModel!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "searchViewController") as? SearchViewController else {
            XCTFail("Could not instantiate viewController as SearchViewController")
            return
        }
        sut = viewController
        sut.loadViewIfNeeded()
        
        viewModel = MockSearchViewModel(viewModelToViewBinding: sut)
        
        sut.viewModel = viewModel
    }
    
    func test_newSearchEmpty() {
        sut.searchController.searchBar.text = ""
        sut.newSearch()
    }
    
    func test_newSearchError() {
        sut.searchController.searchBar.text = "test search"
        sut.newSearch()
    }
    
    func test_newSearchSuccess() {
        let result = Result(id: "123456789", title: "Producto x", price: 1000, permalink: "", thumbnail: "")
        var results = [Result]()
        results.append(result)
        
        viewModel.searchData = SearchData(results: results)
        sut.searchController.searchBar.text = "test search"
        sut.newSearch()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
