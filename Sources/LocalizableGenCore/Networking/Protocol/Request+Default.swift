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

    var defaultQueryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "access_token", value: GoogleOAuth.share.accessToken)
        ]
    }

    var url: URL {
        let defaultURL = URL(string: urlPath)!
        guard let urlComponentUnwrapped = URLComponents(string: urlPath) else {
            return defaultURL
        }
        var urlComponent = urlComponentUnwrapped
        var finalQueryItems = defaultQueryItems
        if let queryItemsUnwrapped = queryItem {
            finalQueryItems.append(contentsOf: queryItemsUnwrapped.toArrayURLQueryItem())
        }
        urlComponent.queryItems = finalQueryItems
        return urlComponent.url ?? defaultURL
    }

    var semaphore: DispatchSemaphore { return .init(value: 0) }
    
    func excute(onSuccess: @escaping (Element) -> Void, onError: @escaping (RequestError) -> Void) {

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
