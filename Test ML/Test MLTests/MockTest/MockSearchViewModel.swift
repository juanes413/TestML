//
//  MockSearchViewModel.swift
//  Test MLTests
//
//  Created by Juan Esteban Pelaez on 17/11/21.
//

import Foundation
@testable import Test_ML

class MockSearchViewModel: SearchViewModel {
    
    var searchData: SearchData?
    var product: Product?
    var description: Descripcion?
    
    override init(viewModelToViewBinding: ServicesViewModelToViewBinding, apiServices: APIService = APIService()) {
        super.init(viewModelToViewBinding: viewModelToViewBinding)
    }
    
    override func searchFromService(searchText: String) {
        if let searchData = self.searchData {
            viewModelToViewBinding?.serviceSearchResult(results: searchData)
        } else {
            viewModelToViewBinding?.serviceError()
        }
    }
    
    override func detailProductFromService(idProduct: String) {
        if let product = self.product {
            viewModelToViewBinding?.serviceDetailProduct(product: product)
        } else {
            viewModelToViewBinding?.serviceError()
        }
    }
    
    override func descripcionProductFromService(idProduct: String) {
        if let descripcion = self.description {
            viewModelToViewBinding?.serviceDescriptionProduct(description: descripcion)
        }
    }

}
