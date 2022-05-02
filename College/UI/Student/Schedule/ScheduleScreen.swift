import SwiftUI

struct ScheduleScreen: View {
    var body: some View {
        List {
            ForEach(Weekday.sorted, id: \.self) { weekday in
                Section(
                    content: {
                        if let subjects = CollegeData.group.schedule.subjectsArray(for: weekday) {
                            ForEach(subjects, id: \.slot) { item in
                                SubjectRow(
                                    slot: item.slot,
                                    subject: item.subject
                                )
                                .listRowBackground(
                                    item.subject.wasPresent
                                    ? Color(red: 0.94, green: 0.94, blue: 0.98)
                                    : Color(red: 1.0, green: 0.45, blue: 0.45)
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

    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
}

private struct SubjectRow: View {
    let slot: Slot
    let subject: Subject

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(slot.startTime)
                Spacer()
                Text(subject.type.rawValue)
            }
            if let grade = subject.grade {
                HStack {
                    Text("Оценка")
                    Spacer()
                    Text(grade)
                }
            }
        }
    }
}

private struct EmptySubjectRow: View {
    var body: some View {
        Text("Выходной")
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleScreen()
    }
}
