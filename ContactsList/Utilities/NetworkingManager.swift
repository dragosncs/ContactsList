//
//  NetworkingManager.swift
//  ContactsList
//
//  Created by Dragos Neacsu on 29.01.2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
    case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return " [❗️] Bad Response from URL \(url)"
            case .unknown: return "[⚠️] Unknown Error occoured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
       return URLSession.shared.dataTaskPublisher(for: url)
              .subscribe(on: DispatchQueue.global(qos: .default))
              .tryMap({ try handleUrlResponse(output: $0, url: url)})
              .retry(3)
              .eraseToAnyPublisher() // To get the type of the publisher
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure (let error):
            print(error.localizedDescription)
        }
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
}
