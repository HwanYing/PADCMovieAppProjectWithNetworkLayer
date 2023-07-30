//
//  MovieDataAgent.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation

protocol MovieDataAgent {
    
    // Get Banners
    func getBannerMovies(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get movie list
    func getMoviesByType(type: String, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Movie Details
    func getMovieDetails(id: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Cinema Data and Time Slots
    func getCinemaAndTimeSlotRecord(token: String, date: String, onSuccess: @escaping ([CinemaVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get seating plan by showtime
    func getSeatingPlanByShowTime(token: String, timeSlotID: Int, date: String, onSuccess: @escaping ([[CinemaSeatVO]]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Snack Categories
    func getSnackCategories(token: String, onSuccess: @escaping ([SnackCategoryVO]) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Snack list by type
    func getSnackListByCategory(id: Int, token: String, onSuccess: @escaping ([SnackDetailsVO]) -> Void, onFailure: @escaping (String) -> Void)
}
