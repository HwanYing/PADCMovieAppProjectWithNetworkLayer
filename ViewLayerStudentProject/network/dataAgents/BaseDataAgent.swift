//
//  BaseDataAgent.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/23.
//

import Foundation
import Alamofire

func fetchDataWithParametersFormData<T: Codable>(forEndPoint endpoint: String, method: HTTPMethod, parameters: [String: Any]?, onSuccess: @escaping (T) -> Void, onFailure: @escaping (Error) -> Void) {
    AF.request("\(BASE_URL)\(endpoint)", method: method, parameters: parameters, encoding: URLEncoding.default)
        .validate(statusCode: 200..<400)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                onSuccess(result)
            case .failure(let error):
                onFailure(error)
            }
        }
}

func fetchDataWithParamsAndHeader<T: Codable>(forEndPoint endpoint: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders, onSuccess: @escaping (T) -> Void, onFailure: @escaping (Error) -> Void) {
    AF.request("\(BASE_URL)\(endpoint)", method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        .validate(statusCode: 200..<400)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                onSuccess(result)
            case .failure(let error):
                onFailure(error)
            }
        }
}
