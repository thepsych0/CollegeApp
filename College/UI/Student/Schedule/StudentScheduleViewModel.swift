import Combine
import RealmSwift
import SwiftUI

@MainActor class StudentScheduleViewModel: ObservableObject {

    @Published var student: Student
    @Published var week: Week
    @Published var weekSchedule: StudentSchedule

    @State var showingSheet: Bool = false

    init(student: Student, week: Week) {
        self.student = student
        self.week = week
        self.weekSchedule = ServerMock.getSchedule(for: student, week: week)
        updateActivities()
        updateHomework()
    }

    func destination(group: Group, weekday: Weekday, slot: Slot) -> AnyView {
        let viewModel = SubjectActivityViewModel(group: group, date: week.getDate(for: weekday), slot: slot)
        let screen = SubjectActivityScreen(viewModel: viewModel)
        return AnyView(screen)
    }

    private func updateActivities() {
        weekSchedule.forEach { item in
            item.value.forEach {
                let filters: [String: Any] = [
                    "groupNumber": student.groupNumber,
                    "slotRawValue": $0.key.rawValue,
                    "dateString": "'\(DateFormatter.standardDay.string(from: week.getDate(for: item.key)))'"
                ]
                guard let activityObject = realm.objects(SubjectActivityObject.self)
                    .filter(
                        filters
                            .map { "\($0.key) == \($0.value)" }
                            .joined(separator: " AND ")
                    )
                    .first else { return }
                weekSchedule[item.key]?[$0.key]?.activity = activityObject.activity
            }
        }
    }

    private func updateHomework() {
        weekSchedule.forEach { item in
            item.value.forEach {
                let filters: [String: Any] = [
                    "groupNumber": student.groupNumber,
                    "slotRawValue": $0.key.rawValue,
                    "dateString": "'\(DateFormatter.standardDay.string(from: week.getDate(for: item.key)))'"
                ]
                guard let homeworkObject = realm.objects(HomeworkObject.self)
                    .filter(
                        filters
                            .map { "\($0.key) == \($0.value)" }
                            .joined(separator: " AND ")
                    )
                        .first else { return }
                weekSchedule[item.key]?[$0.key]?.homework = homeworkObject.text
            }
        }
    }

    private let realm = try! Realm()
    private var disposeBag = Set<AnyCancellable>()
}
