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
    

}
