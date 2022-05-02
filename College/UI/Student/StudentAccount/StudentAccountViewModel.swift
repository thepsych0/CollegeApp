import SwiftUI
import Combine

@MainActor final class StudentAccountViewModel: ObservableObject {
    @Published var student: Student
    @Published var shouldShowSchedule = false

    init(student: Student) {
        self.student = student
    }

    func didTapScheduleButton() {
        shouldShowSchedule = true
    }

    var imageName: String {
        switch student.gender {
        case .male:
            return "studentMale"
        case .female:
            return "studentFemale"
        }
    }

    var scheduleDestination: AnyView {
        let viewModel = WeekViewModel()
        return AnyView(WeeksScreen(viewModel: viewModel))
    }
}
