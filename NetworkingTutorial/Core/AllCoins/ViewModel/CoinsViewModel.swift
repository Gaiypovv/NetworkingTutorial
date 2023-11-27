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
    
    init() {
        fetchPrice(coin: "ethereum")
    }
    
    func fetchPrice(coin: String) {
        let urlSting = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlSting) else { return }
        
        print("Fetching price...")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Did recieve data \(data)")
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            print(jsonObject)
            
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value")
                return
            }
            guard let price = value["usd"] else { return }
         
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "$ \(price)"
            }
            
        }.resume()
        
        print("Did reach end of function")
    }
}
