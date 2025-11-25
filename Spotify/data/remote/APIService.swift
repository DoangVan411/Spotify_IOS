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
        static let baseURL = "https://api.deezer.com/"
        static let hits = "playlist/908622995"
        static let playerUrl = "me/player/play"
        static let deviceId = "1DA0E74E-5C53-446B-83A1-D7ABED8A1D32"
        static let artists = "artist/27/related"
    }
    
    enum APIError: Error {
        case failedToGetData
        case invalidToken
    }
    
    let session: URLSession = URLSession.shared
    
    public func getHits(completion: @escaping (Result<[DeezerTrack], Error>) -> Void) {
        let url = URL(string: Constant.baseURL + Constant.hits)!
        
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
                    print(hits)
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
    
    func getArtists(completion: @escaping (Result<[Artist], Error>) -> Void) {
        let url = Constant.baseURL + Constant.artists
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        self.session.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let res = try JSONDecoder().decode(ArtistsResponse.self, from: data)
                let artists = Array(res.data.prefix(10))
                completion(.success(artists))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
