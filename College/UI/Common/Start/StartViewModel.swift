import SwiftUI
import Combine

@MainActor class StartViewModel: ObservableObject {}

enum UserType: String {
    case teacher = "Преподаватель"
    case student = "Студент"
    case admin = "Администратор"
}
