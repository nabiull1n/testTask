//
//  ImageRequestManager.swift
//  TestTaskIT-Link
//
//  Created by Денис Набиуллин on 20.05.2023.
//

import Foundation

final class ImageRequestManager {
    
    static let shared = ImageRequestManager()
    private init() {}
    private let urlString = "https://it-link.ru/test/images.txt"
    // MARK: - request
    func loadImagesURLString (completion: @escaping([String]) -> ()) {
        
        var array: [String] = []
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                print("\(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            
            if let contents = String(data: data, encoding: .utf8) {
                DispatchQueue.global().async {

                    let lines = contents.components(separatedBy: .newlines)
                    let imageURLs = lines.filter { !$0.isEmpty }
                    for url in imageURLs {
                        array.append(url)
                    }
                    let filteredArray = array.filter { $0.contains("images") || $0.contains("jpg") }
                    DispatchQueue.main.async {
                        completion(filteredArray)
                    }
                    
                }
            }
        }
        task.resume()
    }
}
