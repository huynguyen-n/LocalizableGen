//
//  Request.swift
//
//
//  Created by Huy Nguyen on 05/04/2022.
//

import Foundation

//  MARK:- Define Request Entities

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

    associatedtype Element

    var basePath: String { get }

    var endpoint: String { get }

    var httpMethod: HTTPMethod { get }

    var param: Parameter? { get }

    var semaphore: DispatchSemaphore { get }

    var queryItem: QueryItem? { get }

    func decode(data: Data) -> Element?
}


