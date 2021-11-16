//
//  SearchViewModel.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 15/11/21.
//

import Foundation

class SearchViewModel {
    
    private var viewModelToViewBinding: ServicesViewModelToViewBinding?
    private var apiServices: APIService!
    
    init(viewModelToViewBinding: ServicesViewModelToViewBinding) {
        self.viewModelToViewBinding = viewModelToViewBinding
        self.apiServices = APIService()
    }
    
    //Invocar servicio api para el buscador
    func searchFromService(searchText: String) {
        apiServices.searchText(searchText: searchText, completion: { [weak self] success, model in
            if success, let searchData = model {
                self?.viewModelToViewBinding?.searchResult(results: searchData)
            } else {
                self?.viewModelToViewBinding?.searchResultError()
            }
            
        })
        
    }
    
}

// MARK: - Protocols
protocol ServicesViewModelToViewBinding: AnyObject {
    func searchResult(results: SearchData)
    func searchResultError()
}
