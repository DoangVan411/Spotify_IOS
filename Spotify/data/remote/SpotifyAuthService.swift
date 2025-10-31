//
//  SpotifyAuthService.swift
//  Spotify
//
//  Created by VanDoang on 27/10/25.
//

import Foundation
import UIKit

class SpotifyAuthService {
    static let shared = SpotifyAuthService()
    
    private init(){}
    
    struct AccessToken: Codable {
        var accessToken: String
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
        }
    }
    
    func getAccessToken(completion: @escaping (String?) -> Void) {
        let clientID = "ae0daad03e774f09ab28ce06c22e362d"
        let clientSecret = "4c00b8c55588467488dfea1827ab65da"
        let authString = "\(clientID):\(clientSecret)"
            .data(using: .utf8)!
            .base64EncodedString()
        
        var request = URLRequest(url: URL(string: "https://accounts.spotify.com/api/token")!)
        request.httpMethod = "POST"
        request.setValue("Basic \(authString)", forHTTPHeaderField: "Authorization")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(AccessToken.self, from: data)
                completion(res.accessToken)
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                    appDelegate.accessToken = res.accessToken
                }
            } catch {
                return
            }
        }.resume()
    }
}
