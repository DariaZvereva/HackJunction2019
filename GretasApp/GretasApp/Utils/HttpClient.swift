//
//  HttpClient.swift
//  GretasApp
//
//  Created by Daria Zvereva on 15/11/2019.
//  Copyright © 2019 Daria Zvereva. All rights reserved.
//

import Foundation

class HttpClient {
    var baseUrl: String
    var token: String
    
    init(_baseUrl: String, _token: String) {
        baseUrl = _baseUrl
        token = _token
    }
    
    func doAndParseRequest(urlrequest: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = URLSession.shared.dataTask(with: urlrequest) {
           data = $0
           response = $1
           error = $2

           semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)
        return (data, response, error)
    }
    
    func getProductByShopAndCode(shopCode: String, productCode: String) -> (data: Data?, response: URLResponse?, error: Error?) {
        let url = URL(string: String(format: "\(self.baseUrl)/products/\(shopCode)/\(productCode)"))!
        var urlrequest = URLRequest(url: url)
        urlrequest.addValue(self.token, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        let (data, response, error) = self.doAndParseRequest(urlrequest: urlrequest)
        return (data, response, error)
    }
    
    func reciveProductCategory(item: String) -> (data: Data?, response: URLResponse?, error: Error?) {
        let url = URL(string: String(format: "\(self.baseUrl)/search/products"))!
        print(url)
        var urlrequest = URLRequest(url: url)
        urlrequest.httpMethod = "POST"
        let body: [String: Any] = [
            "query": item,
            "view": ["limit": 1]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        urlrequest.httpBody = jsonData
        urlrequest.addValue(self.token, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        urlrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response, error) = self.doAndParseRequest(urlrequest: urlrequest)
        return (data, response, error)
    }

}
