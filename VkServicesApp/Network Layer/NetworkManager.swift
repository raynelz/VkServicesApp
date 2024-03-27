//
//  NetworkManager.swift
//  VkServicesApp
//
//  Created by Захар Литвинчук on 26.03.2024.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

protocol NetworkManagerProtocol {
    func fetchData(completion: @escaping (Result<ServiceModel, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    func fetchData(completion: @escaping (Result<ServiceModel, NetworkError>) -> Void) {
        if let urlString = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") {
            let request = URLRequest(url: urlString)
            
            let decoder = JSONDecoder()
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.transportError(error)))
                    return
                }

                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(.failure(.serverError(statusCode: response.statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let services = try decoder.decode(ServiceModel.self, from: data)
                    completion(.success(services))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }.resume()
        }
    }
}
