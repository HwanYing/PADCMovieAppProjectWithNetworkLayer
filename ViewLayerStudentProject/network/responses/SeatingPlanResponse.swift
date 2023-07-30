//
//  SeatingPlanResponse.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/27.
//

import Foundation
import Combine

struct SeatingPlanResponse: Codable {
    var code: Int?
    var message: String?
    var data: [[CinemaSeatVO]]?
}
