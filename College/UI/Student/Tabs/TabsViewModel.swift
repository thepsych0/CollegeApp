import SwiftUI
import Combine

@MainActor final class TabsViewModel: ObservableObject {
    @Published var student: Student

    init(student: Student) {
        self.student = student
    }
}
