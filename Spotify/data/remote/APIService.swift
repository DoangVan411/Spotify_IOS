//
//  APIService.swift
//  Spotify
//
//  Created by VanDoang on 27/10/25.
//

import Foundation
import UIKit

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    struct Constant {
        static let baseURL = "https://api.spotify.com/v1/"
        static let hits = "playlists/3cEYpjA9oz9GiPac4AsH4n/tracks"
        static let playerUrl = "me/player/play"
        static let deviceId = "1DA0E74E-5C53-446B-83A1-D7ABED8A1D32"
    }
    
    enum APIError: Error {
        case failedToGetData
        case invalidToken
    }
    
    let session: URLSession = URLSession.shared
    
    public func getHits(completion: @escaping (Result<[DeezerTrack], Error>) -> Void) {
        let url = URL(string: "https://api.deezer.com/playlist/908622995")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = self.session.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                print("Lỗi ở đây")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let res = try JSONDecoder().decode(DeezerPlaylistResponse.self, from: data)
                let hits = Array(res.tracks.data.prefix(10))
                DispatchQueue.main.async{
                    completion(.success(hits))
                }
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) {data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            }
        }.resume()
    }
    
    func playTrack (trackURL: String, completion: @escaping (Bool?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let url = URL(string: trackURL)
        
        session.dataTask(with: url!) {data, response, error in
            if let data = data {
                print("Yes response body")
            }
            if let error = error {
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            
            completion(httpResponse.statusCode == 204)
        }.resume()
    }
}
