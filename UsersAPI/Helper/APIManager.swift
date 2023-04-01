//
//  APIManager.swift
//  UsersAPI
//
//  Created by Ahmet Ali ÇETİN on 31.03.2023.
//

import UIKit

enum NetworkError: Error {
    case urlError
    case invalidData
    case invalidResponse
    case decodingError(_ error: Error)
}


typealias Handler = (Result<[UserModel], NetworkError>) -> Void

class APIManager {
    static let shared = APIManager()
    private init() {
        
    }
    
    func fetchUsers(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.url) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                print("buraya girdi wrong data")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let users = try jsonDecoder.decode([UserModel].self, from: data)
                completion(.success(users))
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
        }.resume()
    }
}
