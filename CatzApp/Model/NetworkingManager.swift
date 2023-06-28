//
//  NetworkingManager.swift
//  CatzApp
//
//  Created by Majkel on 28/06/2023.
//

import Foundation

class NetworkingManager {
    func getBread(completion: @escaping (_ bread: [Bread]) -> (Void)) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedJson = try JSONDecoder().decode([Bread].self, from: data)
                    completion(decodedJson)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getBreadImage(id: String?, completion: @escaping (_ : [BreadImage]) -> (Void)) {
        
        let urlId = "https://api.thecatapi.com/v1/images/search?breed_ids=\(id ?? "nil")"
        print(urlId)
        
        
        guard let url = URL(string: urlId) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    if let decodedJson = try? JSONDecoder().decode([BreadImage].self, from: data) {
                        completion(decodedJson)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
