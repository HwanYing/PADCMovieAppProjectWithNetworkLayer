//
//  UserVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/23.
//

import Foundation

struct UserVO: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var phone: String?
    var totalExpense: Int?
    var profileImage: String?
    var token: String?
    
    enum codingKeys: String, CodingKey {
        case id
        case name, email, phone
        case profileImage = "profile_image"
        case totalExpense = "total_expense"
        case token
    }
    
    func toUserObject() -> UserObject {
        let object = UserObject()
        object.id = self.id
        object.name = self.name
        object.email = self.email
        object.phone = self.phone
        object.totalExpense = self.totalExpense
        object.profileImage = self.profileImage
        object.token = self.token
        return object
    }
}
