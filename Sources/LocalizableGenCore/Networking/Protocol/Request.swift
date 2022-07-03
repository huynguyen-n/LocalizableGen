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
    case invalidURL(url: URL?)
    case nilData(urlRequest: URLRequest)
    case parseJSON(data: Data)
    case error(error: Error?)

    func logMessage() {
        switch self {
        case .invalidURL(let url):
            Log.message("Invalid URL: \(url?.path ?? "")", to: .error)
        case .nilData(let urlRequest):
            Log.message(log(request: urlRequest), to: .error)
        case .parseJSON(let data):
            Log.message(data, to: .error)
        case .error(let error):
            Log.message(error.debugDescription, to: .error)
        }
    }

    private func log(request: URLRequest) -> String {
        var result = "\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n"

        defer {
            result += "\n - - - - - - - - - -  END - - - - - - - - - - \n"
        }

        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var output = """
       \(urlAsString) \n\n
       \(method) \(path)?\(query) HTTP/1.1 \n
       HOST: \(host)\n
       """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        result += output
        return result
    }
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

    var queryItem: QueryItem? { get }

    func decode(data: Data) -> Element?
}


