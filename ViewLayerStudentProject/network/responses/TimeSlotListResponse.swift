//
//  TimeSlotListResponse.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/26.
//

import Foundation

struct TimeSlotListResponse: Codable {
    var code: Int?
    var message: String?
    var data: [CinemaVO]?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}
