//
//  UserModelImpl.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation

class UserModelImpl: UserModel {
   
    static let shared = UserModelImpl()
    
    private init() {}
    
    // Data Agent
    let uDataAgent: UserDataAgent = UserDataAgentImpl.shared
    
    // Dao
    let userDao = UserDao.shared
    
    func getOTPCode(phoneNo: String, onSuccess: @escaping (GetOTPVO) -> Void, onFailure: @escaping (String) -> Void) {
        uDataAgent.getOTPCode(phoneNo: phoneNo, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func checkOTPCode(phone: String, otp: String, onSuccess: @escaping (UserInfoResponse) -> Void, onFailure: @escaping (String) -> Void) {
        uDataAgent.checkOTPCode(phone: phone, otp: otp) { user in
            onSuccess(user)
            
            var userVO = user.data
            userVO?.token = user.token
            
            // Save User info to UserObject
            self.userDao.saveUserInfo(user: userVO ?? UserVO()) // UserVO
        } onFailure: { errorString in
            onFailure(errorString)
        }

    }
    
    func getCities(onSuccess: @escaping (CityListResponse) -> Void, onFailure: @escaping (String) -> Void) {
        uDataAgent.getCities(onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func setCity(cityID: Int, onSuccess: @escaping (BaseVO) -> Void, onFailure: @escaping (String) -> Void) {
        
        let token = self.getTokenFromDatabase()

        uDataAgent.setCity(token: token, cityID: cityID) { response in
            onSuccess(response)
            self.userDao.setUserCity(token: token, cityID: cityID)
        } onFailure: { errorString in
            onFailure(errorString)
        }
    }
    
    func getTokenFromDatabase() -> String {
        return userDao.getUserToken()
    }
    
}
