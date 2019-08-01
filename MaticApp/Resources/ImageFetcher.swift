//
//  ImageFetcher.swift
//  MaticApp
//
//  Created by Manish Kumar on 01/08/19.
//  Copyright © 2019 manish. All rights reserved.
//

import Foundation
import UIKit

class ImageFetcher {
    static var sharedInstance: ImageFetcher = ImageFetcher()
    
    //api call to fetch image details
    func fetchImagesInfo(for index: Int, completion: @escaping (String?, Bool, Error?) -> ()) {
        
        var request = URLRequest(
            url: URL(string: "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=d98f34e2210534e37332a2bb0ab18887&format=json&extras=url_n&page=\(index)&per_page=1"
                )!
            )
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, error in
            do {
                if error != nil {
                    completion(nil, false, error)
                    return
                }
                if var datastring = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                    datastring = datastring.replacingOccurrences(of: "jsonFlickrApi(", with: "")
                    datastring = datastring.substring(to: datastring.index(before: datastring.endIndex))
                    if let data = datastring.data(using: .utf8),
                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let imagesDict = json["photos"] as? NSDictionary {
                        let imageURLString = self.getImages(fromImageArray: imagesDict["photo"] as! [NSDictionary])
                        completion(imageURLString, true, nil)
                    }
                }
            } catch {
                completion(nil, false, nil)
                print("Error deserializing JSON: \(error)")
            }
            }.resume()
    }
    
    func getImages(fromImageArray images:[NSDictionary]) -> String {
        var urlStrings: [String] = []
        for image in images {
            let urlString = image["url_n"] as! String
            urlStrings.append(urlString)
        }
        return urlStrings[0]
    }
    
    func fetchImage(index: Int, imageURL: String, completion:@escaping (UIImage?, Error?) -> ()) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion(nil, error)
                    return
            }
            completion(image, error)
            }.resume()
    }
}
