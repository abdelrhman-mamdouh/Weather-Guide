import SwiftUI
import Kingfisher

struct ThreeDayForecastView: View {
    var threeDayForecast: [ForecastDay]

    var body: some View {
        VStack {
            List {
                Section(header: Text("3-Day Weather Forecast")
                    .font(.headline)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    ForEach(threeDayForecast) { forecast in
                        NavigationLink(destination: HourlyForecastView(hourlyForecast: forecast.hour)) {
                            HStack(alignment: .center) {
                                Text("\(getShortDayName(epoch: forecast.date_epoch))")
                                    .frame(maxWidth: 50, alignment: .leading)
                                    .bold()
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)

                                KFImage(URL(string: "https:\(forecast.day.condition.icon)"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)

                                Text("\(Int(forecast.day.mintemp_c))° - \(Int(forecast.day.maxtemp_c))°")
                                    .frame(maxWidth: 100, alignment: .leading)
                                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                            }
                        }
                        .listRowBackground(Color.white.blur(radius: 100).opacity(1))
                    }
                }
            }
            .scrollDisabled(true)
            .frame(maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            .preferredColorScheme(.dark)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ThreeDayForecastView(threeDayForecast: [ForecastDay.example])
        .background(Color.blue)
}

// Helper functions and data models would go here
