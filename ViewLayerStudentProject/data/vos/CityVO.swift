//
//  CityVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/4.
//

import Foundation

struct CityVO: Codable {
    var id: Int?
    var cityName: String?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cityName = "name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
