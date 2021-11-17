//
//  ApiSearch.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 15/11/21.
//
import Foundation

class APIService: NSObject {
    
    let searchBaseUrl = "https://api.mercadolibre.com/sites/MCO/search?q="
    let productBaseUrl = "https://api.mercadolibre.com/items/"
    
    //Invocacion del servicio de busqueda
    func searchText(searchText: String, completion: @escaping (_ success: Bool, _ results: SearchData?) -> ()) {
        
        let searchUrl = searchBaseUrl + searchText
        
        guard let url = URL(string: searchUrl) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            do {//Mapear el resultado del servicio al objeto minimo requerido para esta prueba
                let model = try JSONDecoder().decode(SearchData.self, from: data)
                completion(true, model)
            } catch {
                completion(false, nil)
            }
            
        }
        task.resume()
    }
    
    //Invocacion del servicio detalle producto
    func detailProduct(idProduct: String, completion: @escaping (_ success: Bool, _ product: Product?) -> ()) {
        
        let searchUrl = productBaseUrl + idProduct
        
        guard let url = URL(string: searchUrl) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            do {//Mapear el resultado del servicio al objeto minimo requerido para esta prueba
                let model = try JSONDecoder().decode(Product.self, from: data)
                completion(true, model)
            } catch {
                completion(false, nil)
            }
            
        }
        task.resume()
    }
    
    //Invocacion del servicio detalle producto
    func descriptionProduct(idProduct: String, completion: @escaping (_ success: Bool, _ description: Descripcion?) -> ()) {
        
        let searchUrl = productBaseUrl + idProduct + "/description?api_version=2"
        
        guard let url = URL(string: searchUrl) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            do {//Mapear el resultado del servicio al objeto minimo requerido para esta prueba
                let model = try JSONDecoder().decode(Descripcion.self, from: data)
                completion(true, model)
            } catch {
                completion(false, nil)
            }
            
        }
        task.resume()
    }
}
