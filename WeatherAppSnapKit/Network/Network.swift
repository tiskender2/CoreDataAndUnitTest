//
//  Network.swift
//  WeatherAppSnapKit
//
//  Created by Tolga İskender on 12.09.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//
import Foundation

class Network {
    private init() {}
    static let shared = Network()
    //let apiKey = "bfbc5a83368b83d9af3a739264606829"
    private let urlSession = URLSession.shared
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = BaseURL.scheme.rawValue
        urlComponents.host = BaseURL.host.rawValue
        return urlComponents
    }
    
    func getWeather(endPoint resources: EndPoint,lat:String,lon:String,completionHandler: @escaping (WeatherModel) -> Void) {
       fetch(with: resources, parameters: [
        "lat": lat,
        "lon": lon], completionHandler: completionHandler)
    }
    func fetch(with resources: EndPoint, parameters: [String: String], completionHandler: @escaping (WeatherModel) -> Void) {
        
        var urlComponents = self.urlComponents
        urlComponents.path = "\(BaseURL.path.rawValue)\(resources)"
        urlComponents.setQueryItems(with: parameters)
        guard let url = urlComponents.url else {
             print("Error with url")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            if let data = data,
                let movies = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                completionHandler(movies)
            }
        })
        task.resume()
    }
}
extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        self.queryItems?.append(URLQueryItem(name: "appid", value: "bfbc5a83368b83d9af3a739264606829"))
    }
}
