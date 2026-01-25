import SwiftUI

struct LandingView: View {

    @State private var navigateToList: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor", bundle: nil)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    Image("icon", bundle: nil)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .aspectRatio(contentMode: .fit)

                    Text("Breeze")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()

                    Text("Weather App")
                        .font(.body)
                        .foregroundStyle(.white)

                    Spacer()

                    Button {
                        navigateToList = true
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(
                                Color(
                                    UIColor(
                                        red: 64 / 255,
                                        green: 144 / 255,
                                        blue: 247 / 255,
                                        alpha: 1
                                    )
                                )
                            )
                            .padding(1)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }

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
