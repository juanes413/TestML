//
//  Product.swift
//  Test ML
//
//  Created by Juan Esteban Pelaez on 16/11/21.
//
import Foundation

// MARK: - Product
struct Product: Codable {
    let id, title: String
    let price: Int
    let originalPrice: Int?
    let currencyID: String
    let initialQuantity, availableQuantity, soldQuantity: Int
    let condition: String
    let pictures: [Picture]
    let acceptsMercadopago: Bool
    let internationalDeliveryMode: String
    let attributes: [Attribute]
    let warranty: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case originalPrice = "original_price"
        case currencyID = "currency_id"
        case initialQuantity = "initial_quantity"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case condition
        case pictures
        case acceptsMercadopago = "accepts_mercadopago"
        case internationalDeliveryMode = "international_delivery_mode"
        case attributes
        case warranty
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let name: String
    let valueName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case valueName = "value_name"
    }
}

// MARK: - Picture
struct Picture: Codable  {
    let url: String
    let secureURL: String

    enum CodingKeys: String, CodingKey {
        case url
        case secureURL = "secure_url"
    }
}

// MARK: - Attribute
struct Descripcion: Codable {
    let plainText: String?

    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
}
