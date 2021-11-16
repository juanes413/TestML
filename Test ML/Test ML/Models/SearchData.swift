//
//  ViewModels.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 14/11/21.
//
import Foundation

//Este modelo es el minimo viable para esta prueba, para el buscador

// MARK: - DataML
struct SearchData: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let id: String
    let title: String
    let price: Int
    let prices: Prices
    let permalink: String
    let thumbnail: String
}


// MARK: - Prices
struct Prices: Decodable {
    let prices: [Price]
}


struct Price: Decodable {
    let type: String
    let amount: Int
}
