//
//  CheckOutRequest.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/8/3.
//

import Foundation

struct CheckOutRequest: Codable {
    var cinemaDayTimeSlotId: Int?
    var seatNumber: String?
    var bookingDate: String?
    var movieId: Int?
    var cardId: Int?
    var snacks: [SnackRequest]?
    
    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeSlotId = "cinema_day_timeslot_id"
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case movieId = "movie_id"
        case cardId = "payment_type_id"
        case snacks
    }
}
