//
//  CoinDetailsView.swift
//  NetworkingTutorial
//
//  Created by Eldar Gaiypov on 30/11/23.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    @ObservedObject var viewModel: CoinDetailsViewModel
    @State private var task: Task<(), Never>?
    
    init(coin: Coin) {
        self.coin = coin
        self.viewModel = CoinDetailsViewModel(coinId: coin.id)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.coinDetails {
                Text(details.name)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                
                Text(details.symbol.uppercased())
                    .font(.footnote)
                
                Text(details.description.text)
                    .font(.footnote)
                    .padding(.vertical)
            }
        }
        .onAppear {
            self.task = Task { await viewModel.fetchCoinDetails() }
        }
        .onDisappear() {
            task?.cancel()
        }
        .padding()
    }
}

//#Preview {
//    CoinDetailsView()
//}
