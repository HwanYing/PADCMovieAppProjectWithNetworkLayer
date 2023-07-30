//
//  MovieListResponse.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/25.
//

import Foundation

struct MovieListResponse: Codable {
    var code: Int?
    var message: String?
    var data: [MovieVO]?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
}
