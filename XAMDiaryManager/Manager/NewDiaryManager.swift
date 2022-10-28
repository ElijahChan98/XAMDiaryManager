//
//  NewDiaryManager.swift
//  XAMDiaryManager
//
//

import Foundation

public enum RequestMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
}

public enum ReqresResult<T> {
    case success(T?)
    case failure(ReqresError?)
}

class NewDiaryManager{
    public static let shared = NewDiaryManager()
    
    func postDiaryDetails(diaryEntry: DiaryEntry, completion: @escaping (ReqresResult<Any>) -> ()) {
        var urlComponents = URLComponents(string: Constants.BASE_URL + Constants.DIARIES)!
        var photos: [String: String] = [:]
        for (index, photo) in diaryEntry.photos.enumerated() {
            // Just upload the photo index for testing purposes. Sending the image data is too expensive
            photos["\(index)"] = DiaryEntry.getPhotoData(photo)
        }
        let parameters: [String: Any] = [
            "comments": diaryEntry.comments,
            "date": diaryEntry.date,
            "area": diaryEntry.area,
            "taskCategory": diaryEntry.taskCategory,
            "tags": diaryEntry.tags,
            "event": diaryEntry.event,
            "photos": photos,
        ]
        let queryItems = [
            URLQueryItem(name: "format", value: "json"),
        ]
        
        urlComponents.queryItems = queryItems
        self.createGenericRequest(url: urlComponents.url!, requestMethod: .post, parameters: parameters) { result in
            completion(result)
        }
    }
    
    private func createGenericRequest(url: URL, requestMethod: RequestMethod, parameters: [String: Any], completion: @escaping (ReqresResult<Any>) -> ()) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonBody
            print("\(request.httpMethod ?? "") \(request.url)")
                    let str = String(decoding: request.httpBody!, as: UTF8.self)
                    print("BODY \n \(str)")
                    print("HEADERS \n \(request.allHTTPHeaderFields)")
        } catch let error {
            print(error)
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 401 {
                        completion(.failure(nil))
                    }
                    else if httpResponse.statusCode == 500 {
                        //internal server error
                        completion(.failure(nil))
                    }
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        print(json)
                        if let payload = json as? [String: Any] {
                            if let error: ReqresError = CodableObjectFactory.objectFromPayload(payload) {
                                completion(.failure(error))
                            }
                            else {
                                completion(.success(payload))
                            }
                        }
                    }
                    catch {
                        do {
                            let responseJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let responseJSON = responseJSON as? [String: Any] {
                                print(responseJSON)
                            }
                        } catch {
                            print(error)
                        }
                        
                        
                    }
                }
                else {
                    completion(.failure(nil))
                }
            }
        }
        task.resume()
    }
}
