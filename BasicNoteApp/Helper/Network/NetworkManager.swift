//
//  NetworkManager.swift
//  BasicNoteApp
//
//  Created by Ali ahmet Erdoğdu on 19.07.2024.
//

import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(_ endpoint: APIEndpoint, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil,completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: endpoint.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        // Set encoding based on HTTP method
        let encoding: ParameterEncoding
        switch method {
        case .get, .delete:
            encoding = URLEncoding.default
        case .post, .put:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }

        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers:headers).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
}
