//
//  CheckOutResponse.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/8/3.
//

import Foundation

struct CheckOutResponse: Codable {
    var code: Int?
    var message: String?
    var data: CheckOutVO?
}
