//
//  UserDataAgentImpl.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/23.
//

import Foundation
import Alamofire

class UserDataAgentImpl: UserDataAgent {
    
    static let shared = UserDataAgentImpl()
    
    private init() {}
    
    func getOTPCode(phoneNo: String, onSuccess: @escaping (GetOTPVO) -> Void, onFailure: @escaping (String) -> Void) {
        let parameters: Parameters = [
            "phone": phoneNo
        ]
        fetchDataWithParametersFormData(forEndPoint: ENDPOINT_GET_OTP, method: .post, parameters: parameters) { (response: GetOTPVO) in
            onSuccess(response)
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }

    }
    
    func checkOTPCode(phone: String, otp: String, onSuccess: @escaping (UserInfoResponse) -> Void, onFailure: @escaping (String) -> Void) {
        let parameters: Parameters = [
            "phone": phone,
            "otp": otp
        ]
        fetchDataWithParametersFormData(forEndPoint: ENDPOINT_SIGN_IN_WITH_PHONE, method: .post, parameters: parameters) { (response: UserInfoResponse) in
            onSuccess(response)
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }

    }
    
    func getCities(onSuccess: @escaping (CityListResponse) -> Void, onFailure: @escaping (String) -> Void) {
        AF.request("\(BASE_URL)\(ENDPOINT_GET_CITIES)")
            .validate(statusCode: 200..<400)
            .responseDecodable(of: CityListResponse.self) { response in
                switch response.result {
                case .success(let result):
                    onSuccess(result)
                case .failure(let error):
                    onFailure(error.localizedDescription)
                }
            }
    }
    
    func setCity(token: String, cityID: Int, onSuccess: @escaping (BaseVO) -> Void, onFailure: @escaping (String) -> Void) {
        let parameters: Parameters = [
            "city_id": cityID
        ]
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        
        fetchDataWithParamsAndHeader(forEndPoint: ENDPOINT_SET_CITY, method: .post, parameters: parameters, headers: header) { (response: BaseVO) in
            onSuccess(response)
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }

        
//        AF.request("\(BASE_URL)\(ENDPOINT_SET_CITY)", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header)
//            .validate(statusCode: 200..<400)
//            .responseDecodable(of: BaseVO.self) { response in
//                switch response.result {
//                case .success(let result):
//                    onSuccess(result)
//                case .failure(let error):
//                    onFailure(error.localizedDescription)
//                }
//            }
    }

  
}
