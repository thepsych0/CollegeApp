import SwiftUI
import Combine

@MainActor class WeekViewModel: ObservableObject {
    @Published var weeks: [Week] = []

    init() {
        self.weeks = ServerMock.getWeeks()
        print(ServerMock.getWeeks())
    }
}
