import SwiftUI

struct DetailView: View {

    var location: Location

    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundColor", bundle: nil)
                    .ignoresSafeArea()

                VStack {

                    Text(location.name)
                        .font(.largeTitle)
                        .foregroundStyle(.white)

                    Image(systemName: location.weather.icon)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(.yellow)

                    Text(location.temperature.temperatureText)
                        .font(.title)
                        .foregroundStyle(.gray)

                    Spacer()

                    HStack {
                        Text(
                            "A warm breeze drifted through tge streets as the afternoon sun hovered behind a veil of scattered clouds. In the north, the air felt dry abd dusty, while the southern coast carried the familiar scent of moisture from the sea. Somewhere in the distance, dark monsoon clouds gathered slowly, hinting at an evening shower that would cool the earth and fill the air with the sound of rain tapping on the rooftops."
                        )
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding()
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DetailView(
        location: Location(
            name: "Mumbai",
            weather: .sunny,
            temperature: Temperature(min: 20, max: 25)
        )
    )
}
