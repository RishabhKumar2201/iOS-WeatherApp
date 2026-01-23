//
//  LIstVIew.swift
//  WeatherApp
//
//  Created by rentamac on 1/23/26.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var viewModel = ListViewModel()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor", bundle: nil).ignoresSafeArea()
                
                List{
                        ForEach(viewModel.filteredLocations){ location in
                                NavigationLink(destination: DetailView(location: location)){
                                            
                                            HStack{
                                                Text(location.name)
                                                    .font(.headline)
                                                    .foregroundStyle(Color.white)
                                                
                                                Spacer()
                                                
                                                Image(systemName: location.weather.icon)
                                                    .foregroundColor(.yellow)
                                                
                                            }
                                        }.listRowBackground(Color.clear)
                                            .frame(height: 60)
                                            
                                        }
                                }
                                .navigationBarBackButtonHidden(true)
                                .toolbar(content: {
                                    ToolbarItem(placement: .topBarLeading) {
                                        Button{
                                            dismiss()
                                        } label: {
                                            Image(systemName: "chevron.backward")
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    
                                    ToolbarItem(placement: .principal) {
                                        Text("Locations").foregroundColor(.white)
                                    }
                                })
                                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search location or city")
            }.scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    ListView()
}

