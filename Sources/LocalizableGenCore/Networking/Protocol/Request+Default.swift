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
    
    var addionalHeader: HeaderParameter? { return ["Content-Type": "application/json", "Accept-Language": "en_US"] }
    
    var urlPath: String { return basePath + endpoint }

    var queryItem: QueryItem? { return nil }

    var urlComponents: URLComponents {
        var urlComponents = URLComponents(string: urlPath)!
        urlComponents.queryItems = [URLQueryItem(name: "access_token", value: GoogleOAuth.share.accessToken)]
        return urlComponents
    }
    
    func excute(onSuccess: @escaping (Element) -> Void, onError: @escaping (RequestError) -> Void) {

        let semaphore = DispatchSemaphore(value: 0)
        guard let request = self.buildURLRequest() else {
            onError(.invalidURL(url: urlComponents.url))
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            defer {
                semaphore.signal()
            }

            guard error == nil else {
                onError(.error(error: error))
                return
            }
            
            guard let data = data else {
                onError(.nilData(urlRequest: request))
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
    
    private func buildURLRequest() -> URLRequest? {

        // Build URL with query items
        var finalURLComponents = urlComponents
        if let queryItem = queryItem {
            finalURLComponents.queryItems?.append(contentsOf: queryItem.toArray())
        }
        guard let url = finalURLComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.timeoutInterval = TimeInterval(10 * 1000)

        // Encode param
        if let params = self.param {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: params.toDictionary(), options: [])
                urlRequest.httpBody = jsonData
            } catch { return urlRequest }
        }
        
        // Add addional Header if need
        if let additinalHeaders = self.addionalHeader {
            for (key, value) in additinalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
}
