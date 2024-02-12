//
//  ContentView.swift
//  App1
//
//  Created by Tamanna Jain on 2/10/24.
//

import SwiftUI
import SwiftData

import SwiftUI

struct ContentView: View {
    var places : [Places] = []
    var body: some View {
        NavigationView {
            List(places) { place in
                ExtractedView(place: place)
            }
            .navigationBarTitle(Text("Places"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(places: testData)
    }
}



struct ExtractedView: View {
    let place: Places
    var body: some View {
        NavigationLink(destination: Text(place.name)){
            HStack {
                Image(place.image)
                    .resizable()
                    .frame(width:50, height:50)
                    .cornerRadius(8)
                VStack(alignment: .leading){
                    Text(place.name)
                    Text("\(place.capacity) People")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
