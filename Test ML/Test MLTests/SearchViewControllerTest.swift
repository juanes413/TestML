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
    private var mockSearchViewModel: MockSearchViewModel?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "searchViewController") as? SearchViewController else {
            XCTFail("Could not instantiate viewController as SearchViewController")
            return
        }
        sut = viewController
        sut.loadViewIfNeeded()
        mockSearchViewModel = MockSearchViewModel(viewModelToViewBinding: sut)
        
    }
    
    func test_newSearchEmpty() {
        sut.searchController.searchBar.text = "test search"
        sut.newSearch()
    }
    
    func test_newSearch() {
        sut.newSearch()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
