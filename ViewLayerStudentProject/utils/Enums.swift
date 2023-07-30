//
//  Enums.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/5/15.
//

import Foundation
import SwiftUI

//Create an `enum` so you can define your options
enum ViewOptionsRoute: Hashable{
    case movieDetailsCS
    case movieDetailsNS
    case timeSlot
    case seatingPlan
    case snack
    case checkout
    case payment
    case paymentSuccess
    
    //Assign each case with a `View`
    @ViewBuilder
    var view: some View{
        switch self{
        case .movieDetailsCS:
            AboutCSMovieView()
        case .movieDetailsNS:
            AboutNSMovieView()
        case .timeSlot:
            TimeSlotScreenView()
        case .seatingPlan:
            SeatingPlanPageView()
        case .snack:
            GrabABiteView()
        case .checkout:
            CheckOutView()
        case .payment:
            PaymentPageVeiw()
        case .paymentSuccess:
            TicketInformationConfirmView()
  
        }
    }
}
enum Page: String {
    case movies = "Movies"
    case cinema = "Cinema"
    case ticket = "Ticket"
    case profile = "Profile"
}

enum MovieType: String, CaseIterable {
    case MOVIE_CURRENT = "current"
    case MOVIE_COMING_SOON = "comingsoon"
}

enum SeatType: String, Codable {
    case SEAT_TYPE_AVAILABLE = "available"
    case SEAT_TYPE_TAKEN = "taken"
    case SEAT_TYPE_SPACE = "space"
    case SEAT_TYPE_TEXT = "text"
}
