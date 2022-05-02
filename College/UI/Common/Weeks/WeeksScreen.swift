import SwiftUI

struct WeeksScreen: View {
    var body: some View {
        NavigationView {
            List(viewModel.weeks, id: \.startDate) { week in
                SubjectRow(week: week)
                    .contentShape(Rectangle())
            }
            .navigationTitle("Недели")
        }
    }

    init(viewModel: WeekViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: WeekViewModel
}

private struct SubjectRow: View {
    let week: Week

    var body: some View {
        NavigationLink(
            destination: ScheduleScreen()
        ) {
            HStack {
                Text(
                    DateFormatter.standardDay.string(from: week.startDate)
                )
                Spacer()
                Text("—")
                Spacer()
                Text(
                    DateFormatter.standardDay.string(from: week.endDate)
                )
            }
        }
        .listRowBackground(getColor(weekState: week.state))
    }

    private func getColor(weekState: Week.State) -> Color {
        switch weekState {
        case .past:
            return Color(UIColor.lightGray)
        case .current:
            return .blue
        case .future:
            return .white
        }
    }
}

struct WeeksScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeeksScreen(viewModel: .init())
    }
}
