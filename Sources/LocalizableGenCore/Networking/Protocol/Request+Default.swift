//
//  Request+Default.swift
//
//
//  Created by Huy Nguyen on 05/04/2022.
//

import Foundation

extension Request {
    
    var basePath: String { return Constant.App.BaseURL }
    
    var param: Parameter? { return nil }
    
    var addionalHeader: HeaderParameter? { return nil }
    
    var defaultHeader: HeaderParameter { return ["Accept": "application/json", "Accept-Language": "en_US"] }
    
    var urlPath: String { return basePath + endpoint }
    
    var url: URL {
        let url = URL(string: urlPath)!
        if let queryItems = self.queryItems {
            var urlComponent = URLComponents(string: urlPath)
            urlComponent?.queryItems = queryItems
            return urlComponent?.url ?? url
        }
        return url
    }

    var semaphore: DispatchSemaphore { return .init(value: 0) }
    
    func excute(onSuccess: @escaping (CodableResponse) -> Void, onError: @escaping (RequestError) -> Void) {

        defer {
            semaphore.signal()
        }

        let request = self.buildURLRequest()

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                onError(.error(error: error))
                return
            }
            
            guard let data = data else {
                onError(.nilData)
                return
            }

            guard let result = self.decode(data: data) else {
                onError(.parseJSON(data: data))
                return
            }

            onSuccess(result)

        }.resume()
        semaphore.wait()
    }
    
    private func buildURLRequest() -> URLRequest {
        
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.timeoutInterval = TimeInterval(10 * 1000)
        
        // Encode param
        do {
            if let params = self.param {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params!, options: [])
            }
        } catch { return urlRequest }
        
        // Add addional Header if need
        if let additinalHeaders = self.addionalHeader {
            for (key, value) in additinalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
}
