//
//  RestaurantDeal.swift
//  HappyTO-App
//
//  Created by Yana Mayzenger on 14/07/2024.
//

import Foundation

struct RestaurantDeal {
    let name: String
    let address: String
    let deals: String
    let days: String

    init(json: [String: String]) {
        self.name = json["name"] ?? ""
        self.address = json["address"] ?? ""
        self.deals = json["deals"] ?? ""
        self.days = json["days"] ?? ""
    }
}

