//
//  MovieModel.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation

protocol MovieModel {
   
    // Get Banners
    func getBannerMovies(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get movie list
    func getMoviesByType(type: String, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Movie Details
    func getMovieDetails(id: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Cinema Data and Time Slots
    func getCinemaAndTimeSlotRecord(date: String, onSuccess: @escaping ([CinemaVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get seating plan by showtime
    func getSeatingPlanByShowTime(timeSlotID: Int, date: String, onSuccess: @escaping ([CinemaSeatVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Snack Categories
    func getSnackCategories(onSuccess: @escaping ([SnackCategoryVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Snack list by type
    func getSnackListByCategory(id: Int, onSuccess: @escaping ([SnackDetailsVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // fetch checkout receipt
    func fetchCheckOut(timeslotId: Int, seatNumber: [String], bookingDate: String, movieId: Int, cardId: Int, snacks: [SnackRequest], onSuccess: @escaping (CheckOutVO) -> Void, onFailure: @escaping (String) -> Void)
    
    // get payment type
    func getPaymentTypeList(onSuccess: @escaping ([PaymentTypeVO]) -> Void, onFailure: @escaping (String) -> Void)
}
