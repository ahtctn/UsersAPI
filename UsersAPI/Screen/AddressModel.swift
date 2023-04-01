//
//  AddressModel.swift
//  UsersAPI
//
//  Created by Ahmet Ali ÇETİN on 31.03.2023.
//

import Foundation

struct AddressModel: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeographyModel
}
