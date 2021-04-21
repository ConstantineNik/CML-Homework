//
//  APIManager.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func performLogIn(completion: @escaping (LoginResult) -> Void)
}

typealias LoginResult = Result<LoginToken, LoginManagerError>
typealias GetCurrentUserResult = Result<UserInfo, LoginManagerError>

class APIManager: APIManagerProtocol {
    
    var barrerToken: LoginToken?
    
    
    private let baseURL: String = "https://re-next-qa.cmlteam.com"
    
    enum ApiRoute: String {
        case login = "/auth/login"
        case getCurrentUser = "/auth/current-user"
        case getAllProperties = "/api/property/list?page=0&pageSize=10&accountId="
    }
  
    
    func performLogIn(completion: @escaping (LoginResult) -> Void) {
        AF.request(baseURL + ApiRoute.login.rawValue,
                   method: .post,
                   parameters: Login(email: "test111@test.com", password: "test1234"),
                   encoder: JSONParameterEncoder.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .validate(statusCode: 200...204)
            .responseJSON {response in
                    switch response.result {
                        case .success:
                            if let data = response.value {
                                completion(self.parseResult(data))
                            }
                        case .failure:
                            completion(.failure(.notAvailable))
                        }
                   }
    }
    
    func performGetCurrentUser(completion: @escaping (GetCurrentUserResult) -> Void) {
    
        var headers: HTTPHeaders? = nil
        if let tokenType = barrerToken?.tokenType, let accessToken = barrerToken?.accessToken {
            headers = ["Authorization": tokenType + " " + accessToken]
        }
        
        AF.request(baseURL + ApiRoute.getCurrentUser.rawValue,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers,
                   interceptor: nil,
                   requestModifier: nil)
            .validate(statusCode: 200...204)
            .responseJSON {response in
                    switch response.result {
                        case .success:
                            if let data = response.value {
                                completion(self.parseUserResult(data))
                            }
                        case .failure:
                            completion(.failure(.notAvailable))
                        }
                   }
    }
    
    func parseResult(_ data: Any?) -> LoginResult {
        guard let data = data else { return .failure(LoginManagerError.dataIsEmptyError) }
        
        do {
            let decoder = JSONDecoder()
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let decodedData = try decoder.decode(LoginToken.self, from: jsonData)
            return .success(decodedData)
        } catch {
            return .failure(LoginManagerError.parsingError(error: error))
        }
    }
    
    func parseUserResult(_ data: Any?) -> GetCurrentUserResult {
        guard let data = data else { return .failure(LoginManagerError.dataIsEmptyError) }
        
        do {
            let decoder = JSONDecoder()
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let decodedData = try decoder.decode(UserInfo.self, from: jsonData)
            return .success(decodedData)
        } catch {
            return .failure(LoginManagerError.parsingError(error: error))
        }
    }
}
