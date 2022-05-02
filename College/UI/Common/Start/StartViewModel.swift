import SwiftUI
import Combine

@MainActor class StartViewModel: ObservableObject {
    @Published var userType: UserType? = nil

    func userTypeSelected(_ userType: UserType) {
        self.userType = userType
    }
}

enum UserType: String {
    case teacher = "Преподаватель"
    case student = "Студент"
}
