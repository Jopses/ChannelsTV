//
//  NetworkClientService.swift
//  ChannelsTV
//
//  Created by Pavel Zorin on 03.12.2022.
//

import UIKit

protocol NetworkClientServiceInput {
    func request(target: NCSTarget,
                     completion: @escaping NetworkClientService.Callback)
}

class NetworkClientService: NetworkClientServiceInput {
    public enum CallbackResult {
        case success(response: Data)
        case failure(error: Error)
    }

    typealias Callback = (CallbackResult) -> Void

    // MARK: - Properties
    private let sessionConfig: URLSessionConfiguration

    // MARK: - Lifecycle
    init() {
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0
    }

    func request(target: NCSTarget, completion: @escaping Callback) {
        guard let requestUrl = URL(string: target.baseURL + target.path) else {
            completion(.failure(error: NetworkErrors.urlNotValid))
            return
        }

        let session = URLSession(configuration: sessionConfig)
        var networkRequest = URLRequest(url: requestUrl)
        networkRequest.httpMethod = target.method.rawValue

        session.dataTask(with: networkRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200 ... 299:
                    guard let responsesData = data else {
                        completion(.failure(error: NetworkErrors.failedToParseResponse))
                        return
                    }
                    DispatchQueue.main.async {
                        completion(.success(response: responsesData))
                    }
                default:
                    guard let error = error else {
                        completion(.failure(error: NetworkErrors.unknownError))
                        return
                    }
                    completion(.failure(error: error))
                }
            }
        }.resume()
    }
}
