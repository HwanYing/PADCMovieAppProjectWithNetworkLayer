//
//  CinemaVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/26.
//

import Foundation
import Combine

struct CinemaVO: Codable, Hashable {
   
    var cinemaId: Int?
    var cinema: String?
    var timeSlots: [Timeslot]?
    
    enum CodingKeys: String, CodingKey {
        case cinemaId = "cinema_id"
        case cinema
        case timeSlots = "timeslots"
    }
    static func == (lhs: CinemaVO, rhs: CinemaVO) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(cinemaId)
    }
}

struct Timeslot: Codable, Hashable {
    var cinemaDayTimeslotID: Int?
    var startTime: String?
    var status: Int?
    
    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
        case status
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(cinemaDayTimeslotID)
    }
}
