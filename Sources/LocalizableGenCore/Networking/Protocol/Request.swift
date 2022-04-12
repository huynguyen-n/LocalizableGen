//
//  Request.swift
//
//
//  Created by Huy Nguyen on 05/04/2022.
//

import Foundation

//  MARK:- Define Request Entities

public typealias Parameters = [String: Any?]?
public typealias HeaderParameter = [String: String]

enum RequestError: Swift.Error {
    case invalidURL
    case nilData
    case parseJSON(data: Data)
    case error(error: Error?)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

//  MARK:- Main Request Features
protocol Request {
    
    associatedtype CodableResponse: Codable
    
    var basePath: String { get }
    
    var endpoint: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var param: Parameters? { get }

    var semaphore: DispatchSemaphore { get }

    var queryItems: [URLQueryItem]? { get }
    
    func decode(data: Data) -> CodableResponse?
}


