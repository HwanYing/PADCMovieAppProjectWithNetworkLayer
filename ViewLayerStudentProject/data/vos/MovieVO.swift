//
//  MovieTypeVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/5.
//

import SwiftUI
import Combine

struct MovieVO: Codable, Hashable, Equatable {
   
    var id: Int?
    var movieTitle: String?
    var imageUrl: String?
    var isActive: Int?
    var createdAt: String?
    var updatedAt: String?
    var originalTitle: String?
    var releaseDate: String?
    var genres: [String]?
    var posterPath: String?
    var overview: String?
    var rating: Double?
    var runtime: Int?
    var casts: [ActorVO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case movieTitle = "title"
        case imageUrl = "url"
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
        case overview
        case rating
        case runtime
        case casts
    }
    
    static func == (lhs: MovieVO, rhs: MovieVO) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    func getPosterPathTogetherWithBaseURL() -> String {
        return "\(IMAGE_BASE_URL)\(posterPath ?? "")"
    }
}
