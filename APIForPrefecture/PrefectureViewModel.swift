//
//  PrefectureViewModel.swift
//  APIForPrefecture
//
//  Created by ちいつんしん on 2021/07/13.
//

import Foundation

struct PrefectureStruct: Codable {
    let result: [Result]
    struct Result: Codable {
        let prefCode: Int
        let prefName: String
    }
}

class PrefectureRepostiroy {
    static func fetchData(completion: @escaping (PrefectureStruct) -> Void) {

        let urlString = "https://opendata.resas-portal.go.jp/api/v1/prefectures"

        let accessKey = "p6yD3M0uVgRn0UFDBT6OnkRevoBY1vVAtGQ0OMdc"

        var urlRequest = URLRequest(url: URL(string: urlString)!)

        urlRequest.addValue(accessKey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            guard let jsonData = data else {
                return
            }

            do {
                let prefData = try JSONDecoder().decode(PrefectureStruct.self, from: jsonData)
                completion(prefData)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
