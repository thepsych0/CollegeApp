import SwiftUI

struct StudentScheduleScreen: View {
    var body: some View {
        List {
            ForEach(Weekday.sorted, id: \.self) { weekday in
                Section(
                    content: {
                        if let subjects = viewModel.weekSchedule.subjectsArray(for: weekday), !subjects.isEmpty {
                            ForEach(subjects, id: \.slot) { item in
                                SubjectRow(
                                    slot: item.slot,
                                    subject: item.subject,
                                    showingSheet: viewModel.showingSheet
                                )
                                .listRowBackground(
                                    item.subject.activity?.wasPresent ?? true
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

    init(viewModel: StudentScheduleViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }

    @ObservedObject private var viewModel: StudentScheduleViewModel
}

private struct SubjectRow: View {
    let slot: Slot
    let subject: Subject
    @State var showingSheet: Bool

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(slot.startTime)
                Spacer()
                Text(subject.type.name)
            }
            if let mark = subject.activity?.mark {
                HStack {
                    Text("Оценка")
                    Spacer()
                    Text(String(mark))
                }
            }
            if let homework = subject.homework, !homework.isEmpty {
                HStack {
                    Text("Д/З")
                    Spacer()
                    Button("Посмотреть") {
                        showingSheet = true
                    }
                    .sheet(isPresented: $showingSheet) {
                        VStack {
                        Text("Домашнее задание")
                            .font(.system(size: 30, weight: .medium))
                            .padding(.bottom, 12)
                        Text(homework)
                            .font(.system(size: 20))
                        }
                        .padding()
                    }
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
        StudentScheduleScreen(
            viewModel: .init(
                student: .testMale,
                week: .init(startDate: .testMonday)
            )
        )
    }
}
