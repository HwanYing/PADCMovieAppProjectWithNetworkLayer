//
//  ActorVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation
import Combine

struct ActorVO: Codable, Hashable, Equatable {
    var adult: Bool?
    var gender: Int?
    var id: Int?
    var knownForDepartment: String?
    var name: String?
    var originalName: String?
    var popularity: Double?
    var profilePath: String?
    var castID: Int?
    var character: String?
    var creditID: String?
    var order: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
    static func == (lhs: ActorVO, rhs: ActorVO) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    func getProfilePathTogetherWithBaseURL() -> String {
        return "\(IMAGE_BASE_URL)\(profilePath ?? "")"
    }
}
