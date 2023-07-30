//
//  CityListResponse.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation

struct CityListResponse: Codable {
    var code: Int?
    var message: String?
    var data: [CityVO]?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}
