import SwiftUI
import Combine

@MainActor final class TeacherAccountViewModel: ObservableObject {
    @Published var teacher: Teacher

    init(teacher: Teacher) {
        self.teacher = teacher
    }
}
