import SwiftUI

struct WeeksScreen: View {
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List(viewModel.weeks, id: \.startDate) { week in
                    WeekRow(viewModel: viewModel, week: week)
                        .contentShape(Rectangle())
                }
                .onAppear {
                    guard let currentWeek = viewModel.weeks
                        .first(where: { $0.state == .current }) else {
                        return
                    }
                    proxy.scrollTo(
                        currentWeek.startDate,
                        anchor: .center
                    )
                }
                .navigationTitle("Недели")
                .toolbar {
                    Button(
                        action: {
                            isPresented = false
                        }
                    ) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }

    init(viewModel: WeekViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }

    @ObservedObject private var viewModel: WeekViewModel
    @Binding private var isPresented: Bool
}

private struct WeekRow: View {
    let viewModel: WeekViewModel
    let week: Week

    var body: some View {
        NavigationLink(
            destination: viewModel.destination(week: week)
        ) {
            VStack(alignment: .leading, spacing: 10) {
                Text(
                    "C \(DateFormatter.standardDay.string(from: week.startDate))"
                )
                .padding(.top, 10)
                Text(
                    "По \(DateFormatter.standardDay.string(from: week.endDate))"
                )
                .padding(.bottom, 10)
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
            return Color(red: 0.94, green: 0.94, blue: 0.98)
        }
    }
}

struct WeeksScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeeksScreen(
            viewModel: .init(userType: .student),
            isPresented: .just(value: true)
        )
    }
}
