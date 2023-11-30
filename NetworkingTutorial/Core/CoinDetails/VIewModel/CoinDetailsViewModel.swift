//
//  CoinDetailsViewModel.swift
//  NetworkingTutorial
//
//  Created by Eldar Gaiypov on 30/11/23.
//

import Foundation

class CoinDetailsViewModel: ObservableObject {
    private let service = CoinDataService()
    private let coinId: String
    
    @Published var coinDetails: CoinDetails?
    
    init(coinId: String) {
        self.coinId = coinId
        
        Task { await fetchCoinDetails() }
    }
    
    @MainActor
    func fetchCoinDetails() async {
        do {
            let details =  try await service.fetchCoinDetails(id: coinId)
            print("DEBUG: Details \(details)")
            self.coinDetails = details
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
    }
}
