//
//  SnackTypeVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/7.
//

import Foundation
import Combine

struct SnackCategoryVO: Codable, Hashable {
    var id: Int?
    var title: String?
    var titleMM: String?
    var isActive: Int?
    var createdAt: String?
    var updatedAt: String?
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case titleMM = "title_mm"
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    static func == (lhs: SnackCategoryVO, rhs: SnackCategoryVO) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
