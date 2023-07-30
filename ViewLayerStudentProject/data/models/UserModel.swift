//
//  UserModel.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation

protocol UserModel {
    // Get OTP
    func getOTPCode(phoneNo: String, onSuccess: @escaping (GetOTPVO) -> Void, onFailure: @escaping (String) -> Void)
    
    // User Sign IN
    func checkOTPCode(phone: String, otp: String, onSuccess: @escaping (UserInfoResponse) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Cities
    func getCities(onSuccess: @escaping (CityListResponse) -> Void, onFailure: @escaping (String) -> Void)
    
    func setCity(cityID: Int, onSuccess: @escaping (BaseVO) -> Void, onFailure: @escaping (String) -> Void)
    
    // get token
    func getTokenFromDatabase() -> String

}
