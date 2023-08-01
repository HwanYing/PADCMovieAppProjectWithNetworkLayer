//
//  MovieModelImpl.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation

class MovieModelImpl: MovieModel {
    
    static let shared = MovieModelImpl()
    
    private init() {}
    
    // Data Agent
    let mDataAgent: MovieDataAgent = MovieDataAgentImpl.shared
    
    // User agent
    let mUserDao: UserDao = UserDao.shared
    
    func getBannerMovies(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void) {
        mDataAgent.getBannerMovies(onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getMoviesByType(type: String, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void) {
        mDataAgent.getMoviesByType(type: type, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getMovieDetails(id: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (String) -> Void) {
        mDataAgent.getMovieDetails(id: id, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    // Get Cinema Data and Time Slots
    func getCinemaAndTimeSlotRecord(date: String, onSuccess: @escaping ([CinemaVO]) -> Void, onFailure: @escaping (String) -> Void){
        
        let token = self.mUserDao.getUserToken()
print("Selected date set for get Data \(date)")
        
        mDataAgent.getCinemaAndTimeSlotRecord(token: token, date: date, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    // Get seating plan by showtime
    func getSeatingPlanByShowTime(timeSlotID: Int, date: String, onSuccess: @escaping ([CinemaSeatVO]) -> Void, onFailure: @escaping (String) -> Void){
        
        let token = self.mUserDao.getUserToken()
        
        mDataAgent.getSeatingPlanByShowTime(token: token, timeSlotID: timeSlotID, date: date, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    // Get Snack Categories
    func getSnackCategories(onSuccess: @escaping ([SnackCategoryVO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        let token = self.mUserDao.getUserToken()

        mDataAgent.getSnackCategories(token: token, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    // Get Snack list by type
    func getSnackListByCategory(id: Int, onSuccess: @escaping ([SnackDetailsVO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        let token = self.mUserDao.getUserToken()

        mDataAgent.getSnackListByCategory(id: id, token: token, onSuccess: onSuccess, onFailure: onFailure)
    }
}
