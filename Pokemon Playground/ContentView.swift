//
//  ContentView.swift
//  Pokemon Playground
//
//  Created by Michael Vance on 11/7/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject private(set) var viewModel: PokemonPagerViewModel
    
    var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
     
    var body: some View {
        ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
            LazyVGrid(columns: twoColumnGrid, spacing: 20) {
                ForEach(viewModel.pokemon, id: \.self) {
                    ImageView(withURL: $0.imageUrl)
                }
            }
        }).onAppear(perform: {
            getPokemon()
        })
    }

    private func getPokemon() {
        viewModel.getPokemon()
    }
    
    struct ImageView: View {
        @ObservedObject var imageLoader:ImageLoader
        @State var image:UIImage = UIImage()

        init(withURL url:String) {
            imageLoader = ImageLoader(urlString:url)
        }

        var body: some View {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100, height:100)
                    .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PokemonPagerViewModel(repository: PokemonRepositoryImpl())).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
