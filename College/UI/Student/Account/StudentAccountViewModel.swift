import SwiftUI
import Combine

@MainActor final class StudentAccountViewModel: ObservableObject {
    @Published var student: Student

    init(student: Student) {
        Student.current = student
        self.student = student
    }

    var imageName: String {
        switch student.gender {
        case .male:
            return "studentMale"
        case .female:
            return "studentFemale"
        }
    }

    func scheduleDestination(isPresented: Binding<Bool>) -> AnyView {
        let viewModel = WeekViewModel(userType: .student)
        return AnyView(WeeksScreen(viewModel: viewModel, isPresented: isPresented))
    }
}
