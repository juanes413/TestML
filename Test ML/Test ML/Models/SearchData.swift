//
//  ViewModels.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 14/11/21.
//
import Foundation

// MARK: - DataML
struct SearchData {
    let results: [Result]
}

// MARK: - Result
struct Result {
    let id: String
    let title: String
    let price: Int
    let prices: Prices
    let permalink: String
    let thumbnail: String
}


// MARK: - Prices
struct Prices {
    let prices: [Price]
}


struct Price {
    let type: String
    let amount: Int
}
