//
//  MovieSeatsVO.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/14.
//

import Foundation

struct MovieSeatsVO {
    var id: String = UUID().uuidString
    var text: String = ""
    var type: String = ""
    
    func isAvailable() -> Bool {
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isTaken() -> Bool {
        return type == SEAT_TYPE_TAKEN
    }
    
    func isText() -> Bool {
        return type == SEAT_TYPE_TEXT
    }
}

let SEAT_TYPE_AVAILABLE = "Available"
let SEAT_TYPE_TAKEN = "Taken"
let SEAT_TYPE_SPACE = "Space"
let SEAT_TYPE_TEXT = "Text"

struct CinemaSeatVO: Codable, Hashable {
    var id: Int?
    var type: SeatType?
    var seatName: String?
    var symbol: String?
    var price: Int?
    
    var uniqueId: String {
        "\(id ?? 0)\(seatName ?? "")\(symbol ?? "")"
    } // 1 A , 2 A, 3A-2A
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case seatName = "seat_name"
        case symbol
        case price
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueId)
    }
    static func == (lhs: CinemaSeatVO, rhs: CinemaSeatVO) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func isAvailable() -> Bool {
        return type == SeatType.SEAT_TYPE_AVAILABLE
    }
    
    func isTaken() -> Bool {
        return type == SeatType.SEAT_TYPE_TAKEN
    }
    
    func isText() -> Bool {
        return type == SeatType.SEAT_TYPE_TEXT
    }
}


