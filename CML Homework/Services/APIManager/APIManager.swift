//
//  APIManager.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 21.04.2021.
//

import Foundation
import Alamofire

protocol APIManagerProtocol {
    func performLogIn(email: String, password: String, completion: @escaping (LoginResult) -> Void)
}

typealias LoginResult = Result<LoginToken, LoginManagerError>
typealias CurrentUserResult = Result<UserInfo, LoginManagerError>
typealias AllPropertiesResult = Result<UserProperties, LoginManagerError>

class APIManager: APIManagerProtocol {
    
    static var barrerToken: LoginToken?
    static var accountId: Int?
    
    
    private let baseURL: String = "https://re-next-qa.cmlteam.com"
    
    enum ApiRoute: String {
        case login = "/auth/login"
        case getCurrentUser = "/auth/current-user"
        case getAllProperties = "/api/property/list?page=0&pageSize=10&accountId="
    }
    
    func performLogIn(email: String, password: String, completion: @escaping (LoginResult) -> Void) {
        AF.request(baseURL + ApiRoute.login.rawValue,
                   method: .post,
                   parameters: Login(email: email, password: password),
                   encoder: JSONParameterEncoder.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .validate(statusCode: 200...204)
            .responseJSON {response in
                    switch response.result {
                        case .success:
                            if let data = response.value {
                                let parsedData = self.parseResult(data, toType: LoginToken.self)
                                APIManager.barrerToken = try? parsedData.get()
                                DispatchQueue.main.async { completion(parsedData) }
                            }
                        case .failure(let error):
                            DispatchQueue.main.async { completion(.failure(.requestError(error: error))) }
                        }
                   }
    }
    
    func performGetCurrentUser(completion: @escaping (CurrentUserResult) -> Void) {
    
        var headers: HTTPHeaders? = nil
        if let tokenType = APIManager.barrerToken?.tokenType, let accessToken = APIManager.barrerToken?.accessToken {
            headers = ["Authorization": tokenType + " " + accessToken]
            
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
                                    let parsedData = self.parseResult(data, toType: UserInfo.self)
                                    APIManager.accountId = try? parsedData.get().accountId
                                    DispatchQueue.main.async { completion(parsedData) }
                                }
                            case .failure:
                                DispatchQueue.main.async { completion(.failure(.notAvailable)) }
                            }
                       }
        }
    }
    
    func performGetAllProperties(completion: @escaping (AllPropertiesResult) -> Void) {
    
        var headers: HTTPHeaders? = nil
        if let tokenType = APIManager.barrerToken?.tokenType, let accessToken = APIManager.barrerToken?.accessToken {
            headers = ["Authorization": tokenType + " " + accessToken]
            
            if let accountId = APIManager.accountId {
                AF.request(baseURL + ApiRoute.getAllProperties.rawValue + String(accountId),
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
                                        DispatchQueue.main.async { completion(self.parseResult(data, toType: UserProperties.self)) }
                                    }
                                case .failure:
                                    DispatchQueue.main.async { completion(.failure(.notAvailable)) }
                                }
                           }
            }
        }
        
    }
    
    func parseResult<T: Decodable>(_ data: Any?, toType type: T.Type) -> Result<T, LoginManagerError> {
        
        guard let data = data else { return .failure(LoginManagerError.dataIsEmptyError) }
        
        do {
            let decoder = JSONDecoder()
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let decodedData = try decoder.decode(T.self, from: jsonData)
            return .success(decodedData)
        } catch {
            return .failure(LoginManagerError.parsingError(error: error))
        }
    }
}
