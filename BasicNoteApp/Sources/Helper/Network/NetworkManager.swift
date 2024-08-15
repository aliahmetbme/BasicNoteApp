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

    func request<T: Decodable>(_ endpoint: APIEndpoint, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: endpoint.urlString) else {
            completion(.failure(NetworkError(code: "url", message: "Invalid URL")))
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

        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                // Hata durumunu işlemek için NetworkError kullanma
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let errorResponse = try decoder.decode(NetworkError.self, from: data)
                        completion(.failure(errorResponse))
                    } catch {
                        print("Error decoding error response: \(error)")
                        completion(.failure(NetworkError(code: "decoding_error", message: "Failed to decode error response")))
                    }
                } else {
                    completion(.failure(NetworkError(code: "request_failed", message: error.localizedDescription)))
                }
            }
        }
    }
}

struct NetworkError: Codable, Error {
    let code: String
    let message: String
}

