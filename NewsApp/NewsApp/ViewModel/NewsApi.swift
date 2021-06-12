//
//  NewsApi.swift
//  NewsApp
//
//  Created by Afif on 12/06/21.
//

//pengirim = ObservableObject
//penerima = ObservedObject

// Pengirim = ObservableObject
// Penerima = ObservedObject

import Combine
import Foundation
import SwiftyJSON


class NewsApi: ObservableObject {
    @Published var data = [News]()
    
    init() {
        let url = "https://newsapi.org/v2/top-headlines?country=id&category=science&apiKey=173d00798c7e4c45a55d2cf8ac4c3a00"
        
        
        let session = URLSession(configuration: .default)

        session.dataTask(with: URL(string: url)!){ (data , _ , err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let items = json["articles"].array!
            
            for i in items{
                let title = i["title"].stringValue
                let description = i["description"].stringValue
                let imurl = i["urlToImage"].stringValue
                
                DispatchQueue.main.async {//asyncrhonus : data nya berjalan di belakang aplikasi = background thread
                    self.data.append(News(title: title, image: imurl, description: description))
                }
            }
        }.resume()
    }
}
