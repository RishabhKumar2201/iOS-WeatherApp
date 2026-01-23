//
//  ContentView.swift
//  WeatherApp
//
//  Created by rentamac on 1/23/26.
//

import SwiftUI

struct LandingView: View {
    
    @State var navigateToList: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("backgroundColor", bundle: nil).ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("icon", bundle: nil)
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .aspectRatio(contentMode: .fit)
              
                    Text("Breeze")
                        .font(Font.largeTitle)
                        .foregroundStyle(Color.white)
                        .bold()
                    
                    Text("Weather App")
                        .font(Font.default)
                        .foregroundStyle(Color.white)

                    Spacer()
                    
                    Button(action: {
                        navigateToList = true
                    }){
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(Color(UIColor(red: 64/255.0, green: 144/255.0, blue: 247/255.0, alpha: 1.0)))
                            .padding(1)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
//                    NavigationLink(destination: ListView()) {
//                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/
//                    }
                    
                    NavigationLink(isActive: $navigateToList) {
                        ListView()
                    } label: {
                        EmptyView()
                    }
                    .hidden()
                }
                .padding()
            }
        }
    }
}

#Preview {
    LandingView()
}
