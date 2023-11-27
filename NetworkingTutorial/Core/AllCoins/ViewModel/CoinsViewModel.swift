//
//  CoinsViewModel.swift
//  NetworkingTutorial
//
//  Created by Eldar Gaiypov on 26/11/23.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var errorMassage: String?
    
    private let service = CoinDataService()
    
    init() {
        Task { await fetchCoins() }
    }
    
    @MainActor
    func fetchCoins() async {
        do {
            self.coins = try await service.fetchCoins()
        } catch {
            guard let error = error as? CoinAPIError else { return }
            self.errorMassage = error.customDescriction
        }
}
    
    func fetchCoinWithComplitionHandler() {
        service.fetchCoinsWithResults { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    self?.errorMassage = error.localizedDescription
                }
            }
        }
    }
}
