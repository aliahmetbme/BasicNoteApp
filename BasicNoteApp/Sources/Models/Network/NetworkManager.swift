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
    
    func request<T: Decodable>(_ endpoint: APIEndpoint, method: HTTPMethod, parameters: Parameters? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: endpoint.urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        

        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        /*
         AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
             switch response.result {
             case .success(let json):
                 print("Yanıt JSON'u: \(json)")
             case .failure(let error):
                 print("Hata: \(error)")
             }
         }
*/
    }
}

enum NetworkError: Error {
    case invalidURL
}
