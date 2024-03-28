//
//  ServiceModel.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 28.03.2024.
//

import Foundation

struct ServiceModel: Decodable {
    let body: Body
    let status: Int
}

struct Body: Decodable {
    let services: [Service]
}

struct Service: Decodable {
    let name, description: String
    let link: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case name, description, link
        case iconURL = "icon_url"
    }
}
