//
//  SearchViewModel.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 15/11/21.
//

import Foundation

class SearchViewModel {
    
    var viewModelToViewBinding: ServicesViewModelToViewBinding?
    private var apiServices: APIService
    
    init(viewModelToViewBinding: ServicesViewModelToViewBinding, apiServices:APIService = APIService()) {
        self.viewModelToViewBinding = viewModelToViewBinding
        self.apiServices = apiServices
    }
    
    //Invocar servicio api para el buscador
    func searchFromService(searchText: String) {
        apiServices.searchText(searchText: searchText, completion: { [weak self] success, model in
            if success, let searchData = model {
                self?.viewModelToViewBinding?.serviceSearchResult(results: searchData)
            } else {
                self?.viewModelToViewBinding?.serviceError()
            }
        })
    }
    
    //Invocar servicio api para el detalle del producto
    func detailProductFromService(idProduct: String) {
        apiServices.detailProduct(idProduct: idProduct, completion: { [weak self] success, model in
            if success, let product = model {
                self?.viewModelToViewBinding?.serviceDetailProduct(product: product)
            } else {
                self?.viewModelToViewBinding?.serviceError()
            }
        })
    }
    
    //Invocar servicio api para la descripcion del producto
    func descripcionProductFromService(idProduct: String) {
        apiServices.descriptionProduct(idProduct: idProduct, completion: { [weak self] success, model in
            if success, let descripcion = model {
                self?.viewModelToViewBinding?.serviceDescriptionProduct(description: descripcion)
            }
        })
    }
    
}
// MARK: - Protocols
protocol ServicesViewModelToViewBinding: AnyObject {
    func serviceSearchResult(results: SearchData)
    func serviceError()
    func serviceDetailProduct(product: Product)
    func serviceDescriptionProduct(description: Descripcion)
}
//Extension para volver los metodos abstractos e invocar solo los necesarios para cada vista o experiencia
extension ServicesViewModelToViewBinding {
    func serviceSearchResult(results: SearchData){}
    func serviceError(){}
    func serviceDetailProduct(product: Product){}
    func serviceDescriptionProduct(description: Descripcion){}
}
