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

    func Request<T: Decodable>(_ endpoint: APIEndpoint, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: endpoint.urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        
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

        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(.decodingError("Failed to decode response")))
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                if let data = response.data {
                    print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                    do {
                        let decoder = JSONDecoder()
                        let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                        completion(.failure(.customError(errorResponse.message)))
                    } catch {
                        print("Error decoding error response: \(error)")
                        completion(.failure(.decodingError("Failed to decode error response")))
                    }
                } else {
                    completion(.failure(.requestFailed(error.localizedDescription)))
                }
            }
        }
    }

    
   func request<T: Decodable>(_ endpoint: APIEndpoint, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil,completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: endpoint.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        print(url)
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
    case requestFailed(String)
    case decodingError(String)
    case customError(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed(let message):
            return "\(message)"
        case .decodingError(let message):
            return "\(message)"
        case .customError(let message):
            return "\(message)"
        }
    }
}
