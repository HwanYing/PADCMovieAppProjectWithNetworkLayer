//
//  UserInfoResponse.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation

struct UserInfoResponse: Codable {
    var code: Int?
    var message: String?
    var data: UserVO?
    var token: String?
   
}
