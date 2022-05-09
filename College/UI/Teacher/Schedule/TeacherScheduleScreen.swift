import SwiftUI

struct TeacherScheduleScreen: View {
    var body: some View {
        List {
            ForEach(Weekday.sorted, id: \.self) { weekday in
                Section(
                    content: {
                        if let groups = viewModel.weekSchedule.groupsArray(for: weekday), !groups.isEmpty {
                            ForEach(groups, id: \.slot) { item in
                                GroupRow(
                                    slot: item.slot,
                                    weekday: weekday,
                                    group: item.group,
                                    viewModel: viewModel
                                )
                                .listRowBackground(
                                    Color(red: 0.94, green: 0.94, blue: 0.98)
                                )
                            }
                        } else {
                            EmptySubjectRow()
                                .listRowBackground(Color.green)
                        }
                    },
                    header: {
                        Text(weekday.name)
                    }
                )
            }
        }
        .navigationTitle("Расписание")
        .padding()
    }

    init(viewModel: TeacherScheduleViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }

    @ObservedObject private var viewModel: TeacherScheduleViewModel
}

private struct GroupRow: View {
    let slot: Slot
    let weekday: Weekday
    let group: Group
    let viewModel: TeacherScheduleViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(slot.startTime)
                Spacer()
                Text("Группа: \(group.number)")
            }
            NavigationLink(
                destination:
                    viewModel.destination(
                        group: group,
                        weekday: weekday,
                        slot: slot
                    )
            ) {
                Text("Оценки / Домашнее задание")
                    .foregroundColor(.blue)
            }
        }
    }
}

private struct EmptySubjectRow: View {
    var body: some View {
        Text("Выходной")
    }
}

struct TeacherScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        TeacherScheduleScreen(
            viewModel: .init(teacher: Teacher.test, week: Week(startDate: Date.testMonday))
        )
    }
}

extension Date {
    static var testMonday: Date {
        DateFormatter.standardDay.date(from: "02.03.2022")!
    }
}
