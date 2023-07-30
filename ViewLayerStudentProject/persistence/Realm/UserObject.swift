//
//  UserObject.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation
import RealmSwift

class UserObject: Object {
    @Persisted(primaryKey: true) dynamic var id: Int?
    @Persisted dynamic var name: String?
    @Persisted dynamic var email: String?
    @Persisted dynamic var phone: String?
    @Persisted dynamic var totalExpense: Int?
    @Persisted dynamic var profileImage: String?
    @Persisted dynamic var token: String?
    @Persisted dynamic var city: Int?
    
    enum codingKeys: String, CodingKey {
        case id
        case name, email, phone
        case profileImage = "profile_image"
        case totalExpense = "total_expense"
        case token
        case city
    }
    
    func toUserVO() -> UserVO {
        return UserVO(id: self.id,
                      name: self.name,
                      email: self.email,
                      phone: self.phone,
                      totalExpense: self.totalExpense,
                      profileImage: self.profileImage,
                      token: self.token
                    )
    }
}
