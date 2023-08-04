//
//  MovieDataAgentImpl.swift
//  ViewLayerStudentProject
//
//  Created by 梁世仪 on 2023/7/24.
//

import Foundation
import Alamofire

class MovieDataAgentImpl: MovieDataAgent {
    
    static let shared = MovieDataAgentImpl()
    
    private init() {}
    
    func getBannerMovies(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void) {
        fetchDataWithParametersFormData(forEndPoint: ENDPOINT_GET_BANNERS, method: .get, parameters: nil) { (response: MovieListResponse) in
            onSuccess(response.data ?? [MovieVO]())
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }

    }
    
    func getMoviesByType(type: String, onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        AF.request("\(BASE_URL)\(ENDPOINT_GET_MOVIES_BY_TYPE)?status=\(type)")
            .validate(statusCode: 200..<400)
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .success(let result):
                    onSuccess(result.data ?? [MovieVO]())
                case .failure(let error):
                    onFailure(error.localizedDescription)
                }
            }

    }
    
    func getMovieDetails(id: Int, onSuccess: @escaping (MovieVO) -> Void, onFailure: @escaping (String) -> Void) {
        let url = "\(BASE_URL)\(ENDPOINT_MOVIE_DETAILS)/\(id)"
        AF.request(url)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: MovieDetailsResponse.self) { response in
                switch response.result {
                case .success(let result):
                    onSuccess(result.data ?? MovieVO())
                case .failure(let error):
                    onFailure(error.localizedDescription)
                }
            }
    }
    
    // Get Cinema Data and Time Slots
    func getCinemaAndTimeSlotRecord(token: String, date: String, onSuccess: @escaping ([CinemaVO]) -> Void, onFailure: @escaping (String) -> Void){
        let parameters: Parameters = [
            "date": date
        ]
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        
        fetchDataWithParamsAndHeader(forEndPoint: ENDPOINT_GET_CINEMA_AND_SHOWTIME, method: .get, parameters: parameters, headers: header) { (response: TimeSlotListResponse) in
            onSuccess(response.data ?? [CinemaVO]())
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }

    }
    
    func getSeatingPlanByShowTime(token: String, timeSlotID: Int, date: String, onSuccess: @escaping ([CinemaSeatVO]) -> Void, onFailure: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        let parameters: Parameters = [
            "cinema_day_timeslot_id": timeSlotID,
            "booking_date": date
        ]
        fetchDataWithParamsAndHeader(forEndPoint: ENDPOINT_GET_SEATING_PLAN, method: .get, parameters: parameters, headers: header) { (response: SeatingPlanResponse) in
            onSuccess(Array(response.data!.joined()) )
//            onSuccess(response.data ?? [[CinemaSeatVO]]())
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }

    }
    
    // Get Snack Categories
    func getSnackCategories(token: String, onSuccess: @escaping ([SnackCategoryVO]) -> Void, onFailure: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        fetchDataWithParamsAndHeader(forEndPoint: ENDPOINT_GET_SNACK_CATEGORY, method: .get, parameters: nil, headers: header) { (response: SnackCategoryResponse) in
            onSuccess(response.data ?? [SnackCategoryVO]())
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }

    }
    
    // Get Snack list by type
    func getSnackListByCategory(id: Int, token: String, onSuccess: @escaping ([SnackDetailsVO]) -> Void, onFailure: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        let parameters: Parameters = [
            "category_id": id
        ]
        fetchDataWithParamsAndHeader(forEndPoint: ENDPOINT_GET_SNACKS, method: .get, parameters: parameters, headers: header) { (response: SnackDetailsInfoResponse) in
            onSuccess(response.data ?? [SnackDetailsVO]())
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }
    }
    
    // fetch checkout receipt
    func fetchCheckOut(token: String, timeslotId: Int, seatNumber: [String], bookingDate: String, movieId: Int, cardId: Int, snacks: [SnackRequest], onSuccess: @escaping (CheckOutVO) -> Void, onFailure: @escaping (String) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        
        let checkOutRequest = CheckOutRequest(
            cinemaDayTimeSlotId: timeslotId,
            seatNumber: seatNumber.first,
            bookingDate: bookingDate,
            movieId: movieId,
            cardId: cardId,
            snacks: snacks
            )
        
        do {
            let jsonData = try JSONEncoder().encode(checkOutRequest)
            let requestParams = try JSONSerialization.jsonObject(with: jsonData)
            if let parameters = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                AF.request("\(BASE_URL)\(ENDPOINT_SET_CHECKOUT)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseDecodable(of: CheckOutResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        debugPrint(value.data ?? CheckOutVO())
                        onSuccess(value.data ?? CheckOutVO())
                    case .failure(let error):
                        onFailure(error.localizedDescription)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    // get payment type
    func getPaymentTypeList(token: String, onSuccess: @escaping ([PaymentTypeVO]) -> Void, onFailure: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        fetchDataWithParamsAndHeader(forEndPoint: ENDPOINT_GET_PAYMENT_TYPE, method: .get, parameters: nil, headers: header) { (response: PaymentTypeResponse) in
            onSuccess(response.data ?? [PaymentTypeVO]())
        } onFailure: { error in
            onFailure(error.localizedDescription)
        }
    }
}
