//
//  ContentView.swift
//  NetworkingTutorial
//
//  Created by Eldar Gaiypov on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12){
                            Text("\(coin.marketCapRank)")
                                .foregroundColor(.gray)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.semibold)
                                
                                Text(coin.symbol.uppercased())
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
            .navigationDestination(for: Coin.self, destination: { coin in CoinDetailsView(coin: coin)
            })
            .overlay {
                if let error = viewModel.errorMassage {
                    Text(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
