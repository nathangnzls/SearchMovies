//
//  APIHandler.swift
//  SearchMovies
//
//  Created by Nathan on 11/11/2019.
//  Copyright © 2019 NJG. All rights reserved.
//

import UIKit
import Alamofire
public enum RequestType {
    case fetchMovies
}

enum NetworkError: Error {
    case unauthorized
    case serverError
    case badRequest
}
class APIHandler: NSObject {
    static let shared = APIHandler()
    fileprivate func urlBuilder( _ request: RequestType, _ url: inout String?, _ movieName: String, _ pageNum: Int) {
        switch request {
        case .fetchMovies:
            url = Constants.BASE_URL + Constants.PATH_MOVIES + Constants.API_KEY  + "&query=\(movieName.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)&page=\(pageNum)"
        }
    }
    func get(request: RequestType , movieName: String, pageNum: Int ,parameters: Parameters, handler:@escaping resquestCompleted) {
        var url : String?
        urlBuilder(request, &url, movieName, pageNum)
        // for test purpuse only
        logRequest(url, nil, parameters)
        Alamofire.request(url ?? "", method: .get, parameters: parameters, headers: nil).responseJSON { response in
            switch response.result{
            case .success( _ as [String:Any]):
                guard let httpCode = response.response?.statusCode else{
                    return handler("Unable to read response code. \n Please try again later.",nil,nil)
                }
                //enter other possible httpcode here
                switch httpCode{
                case 200:
                    guard let responseDict = response.result.value as? [String: Any] else{ return handler("Serialization Error" , nil, nil)}
                    let genericResponse = GenericModel.init(json: responseDict)
                    handler("Fetching success!",
                        genericResponse,
                        nil
                    )
                case 401:
                    return handler("Something went wrong." , nil, NSError.init(domain: "Something went wrong", code: httpCode, userInfo: nil))
                default:
                    return handler("Something went wrong.", nil, nil)
                }
            case .failure(let error as NSError):
                return handler("" , nil, error)

            default:
                return handler("Something went wrong." , nil, nil)
            }
        }
    }
    fileprivate func logRequest(_ url: String?, _ headers: HTTPHeaders?, _ parameters: Parameters) {
        print("\n\n\n REQUEST --- \nURL \(url ?? "Not available") \n\n HEADER VALUE - \n\(headers ?? [:]) \n with Params --- \n\n  \n ---- \n\n\n")
    }
}
