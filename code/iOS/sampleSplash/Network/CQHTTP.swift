//
//  CQHTTP.swift
//  mmas_ios
//
//  Created by Htain Lin Shwe on 31/1/17.
//  Copyright © 2017 mmas. All rights reserved.
//

import Foundation



struct CQHTTPResponse {
    var result: Any?
    var error: NSError?
    
}

class CQHTTP {
    private var headers: Dictionary<String,String> = Dictionary()
    
    
    func getJSONError() -> NSError {
        
        let userInfo =
            [
                NSLocalizedDescriptionKey:  "JSON ERROR",
                NSLocalizedFailureReasonErrorKey : "JSON ERROR"
        ]
        
        let error = NSError(domain: "com.comquas.request", code: 909, userInfo: userInfo)
        return error
    }
    
    enum Method: String {
        case GET = "GET",
        POST = "POST"
    }
    
    
    func setHeader(key: String,value: String) {
        headers[key] = value
    }
    
    func get(url: String,completion:@escaping ((CQHTTPResponse) -> Void))  -> URLSessionDataTask {
        
        return self.send(url: url, httpMethod: .GET, param: nil, completion: completion)
        
    }
    
    func post(url: String,params: Dictionary<String,String>?,httpBody: Bool = false,completion:@escaping ((CQHTTPResponse) -> Void)) -> URLSessionDataTask {
        
        
        var paramString = ""
        
        if httpBody , let p = params {
            do {
                let d = try JSONSerialization.data(withJSONObject: p, options: .prettyPrinted)
                paramString = String(data: d, encoding: .utf8)!
            }
            catch {
                
                let res = CQHTTPResponse(result: nil, error: getJSONError())
                completion(res)
                return URLSessionDataTask()
            }
        }
        else {
            paramString = paramToString(params: params)
        }
        
        return self.send(url: url, httpMethod: .POST, param: paramString, completion: completion)
        
    }
    
    private func send(url: String,httpMethod: Method,param: String?, completion: @escaping ((CQHTTPResponse) -> Void)) -> URLSessionDataTask {
        
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return URLSessionDataTask()
        }
        let sendURL:URL = URL(string: encodedURL)!
        let session = URLSession.shared
        
        var request = URLRequest(url: sendURL)
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        for key in headers.keys {
            request.setValue(headers[key], forHTTPHeaderField: key)
        }
        
        if let paramString = param , httpMethod == .POST {
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            
            guard let data = data, let _:URLResponse = response, error == nil else {
                let res = CQHTTPResponse(result: nil, error: error as NSError?)
                completion(res)
                return
            }
            do {
                
                print(String(data: data, encoding: .utf8) ?? "")
                let res = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let httpres = CQHTTPResponse(result: res, error: nil)
                completion(httpres)
                return
            }
            catch {
                let userInfo =
                    [
                        NSLocalizedDescriptionKey:  "JSON ERROR",
                        NSLocalizedFailureReasonErrorKey : "JSON ERROR"
                ]
                
                let error = NSError(domain: "com.comquas.request", code: 909, userInfo: userInfo)
                let httpres = CQHTTPResponse(result: nil, error: error)
                completion(httpres)
                return
            }
        }
        
        task.resume()
        return task
    }
}

private func paramToString(params: Dictionary<String,String>?) -> String {
    var paramString = ""
    
    if let params = params {
        
        for key in params.keys {
            
            paramString += key + "=" + params[key]! + "&"
        }
        if (paramString != "" ) {
            paramString.remove(at: paramString.index(before: paramString.endIndex))
        }
    }
    
    return paramString
}

