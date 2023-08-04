//
//  SnackDetailsVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/26.
//

import Foundation

struct SnackDetailsVO: Codable, Identifiable {
    var id: Int?
    var name: String?
    var description: String?
    var price: Int?
    var categoryID: Int?
    var image: String?
    var unitPrice: Int?
    var quantity: Int?
    var totalPrice: Int?
    var selectCount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case categoryID = "category_id"
        case image
        case unitPrice = "unit_price"
        case quantity
        case totalPrice = "total_price"
    }
    
    func getSnackImageUrl() -> String {
        return "\(image ?? "")"
    }
}
