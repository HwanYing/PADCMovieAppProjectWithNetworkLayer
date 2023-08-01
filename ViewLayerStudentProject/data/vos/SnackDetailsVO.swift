//
//  SnackDetailsVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/26.
//

import Foundation

struct SnackDetailsVO: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var price: Int?
    var categoryID: Int?
    var image: String?
    var selectCount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case categoryID = "category_id"
        case image
    }
    
    func getSnackImageUrl() -> String {
        return "\(image ?? "")"
    }
}
