import SwiftUI
import Combine

@MainActor class WeekViewModel: ObservableObject {
    @Published var weeks: [Week] = []
    @Published var userType: UserType

    init(userType: UserType) {
        self.userType = userType
        self.weeks = ServerMock.getWeeks()
    }

    func destination(week: Week) -> AnyView? {
        switch userType {
        case .teacher:
            let viewModel = TeacherScheduleViewModel(teacher: Teacher.current!, week: week)
            let screen = TeacherScheduleScreen(viewModel: viewModel)
            return AnyView(screen)
        case .student:
            let viewModel = StudentScheduleViewModel(student: Student.current!, week: week)
            return AnyView(StudentScheduleScreen(viewModel: viewModel))
        case .admin:
            return nil
        }
    }
}
