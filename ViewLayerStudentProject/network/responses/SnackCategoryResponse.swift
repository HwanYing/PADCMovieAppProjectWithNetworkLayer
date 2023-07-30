//
//  SnackListResponse.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/26.
//

import Foundation

struct SnackCategoryResponse: Codable {
    var code: Int?
    var message: String?
    var data: [SnackCategoryVO]?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}
