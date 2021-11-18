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
    private var viewModel: MockSearchViewModel!
    
    private let product = Product(id: "123456789", title: "Producto x", price: 1000, originalPrice: 900, currencyID: "COP", initialQuantity: 900,  availableQuantity: 0, soldQuantity: 0, condition: "new", pictures: [Picture](), acceptsMercadopago: true, internationalDeliveryMode: "", attributes: [Attribute](), warranty: "1 mes")
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "detailViewController") as? DetailViewController else {
            XCTFail("Could not instantiate viewController as DetailViewController")
            return
        }
        sut = viewController
        sut.product = self.product
        sut.loadViewIfNeeded()
        
        viewModel = MockSearchViewModel(viewModelToViewBinding: sut)
        
        sut.viewModel = viewModel
    }
    
    func test_getProductError() {
        sut.viewModel.detailProductFromService(idProduct: product.id)
    }
    
    func test_getDescriptionError() {
        sut.viewModel.descripcionProductFromService(idProduct: product.id)
    }
    
    func test_getProductSucces() {
        viewModel.product = product
        sut.viewModel.detailProductFromService(idProduct: product.id)
    }
    
    func test_getDescriptionSucces() {
        viewModel.description = Descripcion(plainText: "Descripcion")
        sut.viewModel.descripcionProductFromService(idProduct: product.id)
    }
    
    func test_openAttributes() {
        sut.openAttributes()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
