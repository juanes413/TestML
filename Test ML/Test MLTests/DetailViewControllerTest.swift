//
//  DetailViewControllerTest.swift
//  Test MLTests
//
//  Created by Juan Esteban Pelaez on 17/11/21.
//

import XCTest
@testable import Test_ML

class DetailViewControllerTests: XCTestCase {

    private var sut: DetailViewController!
    private var mockSearchViewModel: MockSearchViewModel?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "detailViewController") as? DetailViewController else {
            XCTFail("Could not instantiate viewController as DetailViewController")
            return
        }
        sut = viewController
        sut.loadViewIfNeeded()
        mockSearchViewModel = MockSearchViewModel(viewModelToViewBinding: sut)
    }
    
    func test_openAttributes() {
        sut.openAttributes()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
