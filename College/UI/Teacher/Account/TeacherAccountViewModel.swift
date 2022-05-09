import SwiftUI
import Combine

@MainActor final class TeacherAccountViewModel: ObservableObject {
    @Published var teacher: Teacher

    init(teacher: Teacher) {
        self.teacher = teacher
        Teacher.current = teacher
    }

    func scheduleDestination(isPresented: Binding<Bool>) -> AnyView {
        let viewModel = WeekViewModel(userType: .teacher)
        return AnyView(WeeksScreen(viewModel: viewModel, isPresented: isPresented))
    }
}
