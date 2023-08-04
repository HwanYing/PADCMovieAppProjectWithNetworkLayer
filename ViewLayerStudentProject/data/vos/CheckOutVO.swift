//
//  CheckOutVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/8/3.
//

import Foundation

struct CheckOutVO: Codable {
    var id: Int?
    var bookingNo: String?
    var bookingDate: String?
    var row: String?
    var seat: String?
    var totalSeat: Int?
    var total: String?
    var movieId: Int?
    var cinemaId: Int?
    var userName: String?
    var timeslot: Timeslot?
    var snacks: [SnackDetailsVO]?
    var qrCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookingNo = "booking_no"
        case bookingDate = "booking_date"
        case row
        case seat
        case totalSeat = "total_seat"
        case total
        case movieId = "movie_id"
        case cinemaId = "cinema_id"
        case userName = "username"
        case timeslot
        case snacks
        case qrCode = "qr_code"
    }
}
