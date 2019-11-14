//
//  Environment.swift
//  SearchMovies
//
//  Created by Nathan on 14/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import Foundation

public enum Environment{
    
    enum Keys{
        enum Plist{
            static let rootUrl = "ROOT_URL"
            static let apiKey = "API_KEY"
            static let baseURL = "BASE_URL"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.rootUrl] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let baseURL: String = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        return rootURLstring
    }()

}
