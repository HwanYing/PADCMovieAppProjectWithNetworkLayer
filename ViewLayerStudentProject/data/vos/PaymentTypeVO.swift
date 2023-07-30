//
//  PaymentTypeVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/10.
//

import Foundation

struct PaymentTypeVO: Codable, Identifiable, Hashable {
    var id: Int?
    var title: String?
    var icon: String?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case icon
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
