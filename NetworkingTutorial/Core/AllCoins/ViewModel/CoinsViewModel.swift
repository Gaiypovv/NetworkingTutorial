//
//  CoinsViewModel.swift
//  NetworkingTutorial
//
//  Created by Eldar Gaiypov on 26/11/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMassage: String?
    
    init() {
        fetchPrice(coin: "ethereum")
    }
    
    func fetchPrice(coin: String) {
        let urlSting = "https://ap.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlSting) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("DEBUG: Failed with error \(error.localizedDescription)")
                    self.errorMassage = error.localizedDescription
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMassage = "Bad HTTP Response"
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    self.errorMassage = "Failed to fetch with status code \(httpResponse.statusCode)"
                    return
                }
                print("DEBUG: Response code is \(httpResponse.statusCode)")
                guard let data = data else { return }
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                guard let value = jsonObject[coin] as? [String: Double] else {
                    print("Failed to parse value")
                    return
                }
                
                guard let price = value["usd"] else { return }
                
                self.coin = coin.capitalized
                self.price = "$ \(price)"
            }
        }.resume()
    }
}
