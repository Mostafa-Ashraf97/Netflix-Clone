//
//  Networking.swift
//  Netflix Clone
//
//  Created by A on 18/05/2023.
//

import Foundation

let APIKey = "78ebc7dcbb138a974637b43f956efbdc"
let youtubeAPIKey = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"


class Networking {

    static let shared = Networking()
    
    func fetchData(with keyWord: String, completion: @escaping (Result<[Title], Error>) -> Void) {
            
            let url = URL(string: "https://api.themoviedb.org/3/\(keyWord)?api_key=78ebc7dcbb138a974637b43f956efbdc")
           
            guard let url = url else {return}
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data,
                respone,
                error in
                
                let decoder = JSONDecoder()
                guard let data = data else {return}
                do {
                    let results = try decoder.decode(AllData.self, from: data)
                    guard let myResults = results.results else {return}
                    completion(.success(myResults))
                } catch {
                    completion(.failure(error))
                }
            }
            dataTask.resume()
    }
    
    
    func getDiscoverdMovies(with keyWord: String, completion: @escaping (Result<[Title], Error>) -> Void) {
            
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(APIKey)") else {return }
        
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data,
                respone,
                error in
                
                let decoder = JSONDecoder()
                guard let data = data else {return}
                do {
                    let results = try decoder.decode(AllData.self, from: data)
                    guard let myResults = results.results else {return}
                    completion(.success(myResults))
                } catch {
                    completion(.failure(error))
                    print(error)
                }
                
            }
            dataTask.resume()
    }

    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
            
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
           
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey)&query=\(query)") else {return}
        
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,
                response,
                error in
                
                guard let data = data else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(AllData.self, from: data)
                    guard let myResults = results.results else {return}
                    completion(.success(myResults))

                } catch {
                    completion(.failure(error))
                    print(error)
                               
                }
            }
            task.resume()
        }
    
    func getTitlePreview(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
            
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            guard let url = URL(string: "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=\(youtubeAPIKey)") else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,
                response,
                error in
                
                guard let data = data else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    guard let myResults = results.items else {return}
                    completion(.success(myResults[0]))

                } catch {
                    completion(.failure(error))
                    print(error)
                               
                }
            }
            task.resume()
        }
    
    
}
   




