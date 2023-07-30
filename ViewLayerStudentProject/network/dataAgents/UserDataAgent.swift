//
//  UserDataAgent.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/23.
//

import Foundation
import Alamofire

protocol UserDataAgent {
    // Get OTP
    func getOTPCode(phoneNo: String, onSuccess: @escaping (GetOTPVO) -> Void, onFailure: @escaping (String) -> Void)
    
    // User Sign IN
    func checkOTPCode(phone: String, otp: String, onSuccess: @escaping (UserInfoResponse) -> Void, onFailure: @escaping (String) -> Void)
    
    // Get Cities
    func getCities(onSuccess: @escaping (CityListResponse) -> Void, onFailure: @escaping (String) -> Void)
    
    // Set City
    func setCity(token: String, cityID: Int, onSuccess: @escaping (BaseVO) -> Void, onFailure: @escaping (String) -> Void)
   
}


