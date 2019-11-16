//
//  ContentView.swift
//  GretasApp
//
//  Created by Daria Zvereva on 15/11/2019.
//  Copyright © 2019 Daria Zvereva. All rights reserved.
//

import SwiftUI
import GretasApp

func do_sync() -> String {
//    func synchronousDataTask(urlrequest: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
//        var data: Data?
//        var response: URLResponse?
//        var error: Error?
//        let url = URL(string: "https://kesko.azure-api.net/products/N106/2000686300003")!
//        var urlrequest = URLRequest(url: url)
//        urlrequest.addValue("cd16ea05859948a5be469dafdf0a2a40", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
//        let semaphore = DispatchSemaphore(value: 0)
//
//        let dataTask = URLSession.shared.dataTask(with: urlrequest) {
//           data = $0
//           response = $1
//           error = $2
//
//           semaphore.signal()
//        }
//        dataTask.resume()
//
//        _ = semaphore.wait(timeout: .distantFuture)
//    if let data_ = data {
//         if let json = try? JSONSerialization.jsonObject(with: data_, options: .mutableContainers) as? [String: Any] {
//                        print(json)
//                    }
//    }
//
////    return (data, response, error)
    
    let http_client = HttpClient(_baseUrl: "https://kesko.azure-api.net/", _token: "cd16ea05859948a5be469dafdf0a2a40")
    let (data, response, error) = http_client.getProductByShopAndCode(shopCode: "N106", productCode: "2000686300003")
    
    return String(data: data!, encoding: .utf8)!
}

func get_some_info() -> String {
    
    let url = URL(string: "https://kesko.azure-api.net/products/N106/2000686300003")!
    var request = URLRequest(url: url)
    request.addValue("cd16ea05859948a5be469dafdf0a2a40", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
    var response_: Any = "nil"
    let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

        guard error == nil else {
            return
        }

        guard let data = data else {
            return
        }

        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                response_ = json
//                print(json)
                // handle json...
            }
        } catch let error {
            print(error.localizedDescription)
        }
    })
    print(response_)
    task.resume()
    return "Hello!!!!"
}

struct ContentView: View {
    var body: some View {
        Text(do_sync())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
