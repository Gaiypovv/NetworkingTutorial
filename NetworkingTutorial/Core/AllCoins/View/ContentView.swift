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
        VStack {
            Text("\(viewModel.coin): \(viewModel.price)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
