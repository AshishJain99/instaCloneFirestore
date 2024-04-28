//
//  Post.swift
//  instaCloneFirestore
//
//  Created by Ashish Jain on 28/04/24.
//

import UIKit

final class GetServerResponse{
    
    private let boundary: String = "Boundary-\(UUID().uuidString)"
    
    func GetProcessedImage(url:String,parmeter:[String:Any],timeout:Double? = nil, completion:@escaping(Result<UIImage,Error>)->Void){
        serverResponse(fromURL: url, parameter: parmeter) {[weak self] result in
            switch result{
            case.success(let image):
                completion(.success(image))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func serverResponse(fromURL url: String, parameter:[String:Any],timeout:Double? = nil, completion: @escaping (Result<UIImage,Error>)->Void){
        guard let url = URL(string: url)
        else{ completion(.failure(ServerResponseError.incorrectURL))
            return
        }
        let requestBody = self.multipartFormDataBody(self.boundary, parameter: parameter)
        switch requestBody{
        
        case .success(let data):
            processData(with: data, url: url, timeOut: timeout){[weak self] result in
                
                switch result{
                    
                case .success(let image):
                    completion(.success(image))
                    let x = image
                    print("")
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
                }
            }
        case .failure(_):
            print("Error aagyaa")
        }
    }
    
    private func multipartFormDataBody(_ boundary: String, parameter:[String:Any]) -> Result<Data,DataConversionFailure> {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        for (key,value) in parameter{
            
            if let value = value as? String{
                
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }else if let imageValue = value as? UIImage{
                if let imagePngData = imageValue.pngData(){
                    if let uuid = UUID().uuidString.components(separatedBy: "-").first {
                        body.append("--\(boundary + lineBreak)")
                        body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(uuid).png\"\(lineBreak)")
                        body.append("Content-Type: image/png\(lineBreak + lineBreak)")
                        body.append(imagePngData)
                        body.append(lineBreak)
                    }
                }else{
                    return.failure(.pngConversionIssue)
                }
            }else{
                return.failure(.unexpectedData)
            }
        }
        body.append("--\(boundary)--\(lineBreak)") // End multipart form and return
        return .success(body)
    }
    
    private func processData(with data: Data, url: URL,timeOut:Double? = nil, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let request = self.generateRequest(url: url, httpBody: data)
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeOut ?? 150 // 2 minutes 40 seconds
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request) {[weak self] data, response, error in
            
            
            if let error = error {
                // Handle the error
                
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut {
                    completion(.failure(ImageUploadError.RequestTimeout))
                } else {
                    completion(.failure(ImageUploadError.ProcessingIssue))
                }
                
            } else {
                guard let httpResponse = response as? HTTPURLResponse, let data = data, let image = UIImage(data: data) else {
                    completion(.failure(ImageUploadError.ServerIssue))
                    return
                }
                completion(.success(image))
            }
        }
        task.resume()
    }
    private func generateRequest(url:URL,httpBody: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
    enum ServerResponseError:Error{
        case incorrectURL
    }
    enum DataConversionFailure:Error{
        
        case unexpectedData
        case pngConversionIssue
        
    }
    enum ImageUploadError: Error {
        
        case RequestTimeout
        
        case ServerIssue
        
        case ProcessingIssue
            
    }
    enum unknownError:Error{
        case returnError
    }
}

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
