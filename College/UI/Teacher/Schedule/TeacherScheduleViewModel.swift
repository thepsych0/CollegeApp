import SwiftUI
import Combine

@MainActor class TeacherScheduleViewModel: ObservableObject {
    @Published var teacher: Teacher
    @Published var week: Week
    @Published var weekSchedule: TeacherSchedule

    init(teacher: Teacher, week: Week) {
        self.teacher = teacher
        self.week = week
        self.weekSchedule = ServerMock.getSchedule(for: teacher, week: week)
    }

    func destination(group: Group, weekday: Weekday, slot: Slot) -> AnyView {
        let viewModel = SubjectActivityViewModel(group: group, date: week.getDate(for: weekday), slot: slot)
        let screen = SubjectActivityScreen(viewModel: viewModel)
        return AnyView(screen)
    }
}
