//
//  CoinDetailsView.swift
//  NetworkingTutorial
//
//  Created by Eldar Gaiypov on 30/11/23.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    
    var body: some View {
        Text(coin.name)
    }
}

//#Preview {
//    CoinDetailsView()
//}
