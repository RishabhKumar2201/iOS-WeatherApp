import SwiftUI

struct ListView: View {
//    @StateObject private var viewModel = ListViewModel()
    
    @StateObject private var viewModel =
        ListViewModel(
            weatherService: WeatherService(
                networkService: HttpNetworking()
            )
        )

//    @StateObject private var addLocationViewModel = AddLocationViewModel()
    @State private var showAddLocationSheet = false
    @State private var newLocationName = ""
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor", bundle: nil).ignoresSafeArea()
                
                List {
                    ForEach(viewModel.filteredLocations) { location in
                        NavigationLink(destination: DetailView(location: location, weatherService: WeatherService(networkService: HttpNetworking()))){
                            HStack {
                                Text(location.name)
                                    .font(.headline)
                                    .foregroundStyle(Color.white)
//
                                Spacer()
                                
                                Image(systemName: location.weather.icon)
                                    .foregroundColor(.yellow)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .frame(height: 60)
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("Locations").foregroundColor(.white)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            showAddLocationSheet = true
                        } label:{
                            Text("+   Location").foregroundColor(.white).padding(.horizontal, 1)
                        }
                                        }
                                    }
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search location or city")
            }
        }
        .sheet(isPresented: $showAddLocationSheet) {
            VStack(spacing: 20) {
                
                Text("Add Location")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                TextField("Enter city name", text: $newLocationName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
//                Button {
//                    Task{
//                        await viewModel.addLocation(name: newLocationName)
//                    }
//                    showAddLocationSheet = false
//                    newLocationName = ""
//                } label: {
//                    Text("Add")
//                        .foregroundStyle(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(.blue)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
                
                Button {
                    Task {
                        await viewModel.addLocation(name: newLocationName)
                        
                        showAddLocationSheet = false
                        newLocationName = ""
                    }
                } label: {
                    Text("Add")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                
                .padding(.horizontal)
                .disabled(newLocationName.trimmingCharacters(in: .whitespaces).isEmpty)
                
                Spacer()
            }
            .padding()
        }

    }
}

#Preview {
    ListView()
}
