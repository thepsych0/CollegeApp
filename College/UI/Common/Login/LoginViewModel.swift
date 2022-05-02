import SwiftUI
import Combine

@MainActor final class LoginViewModel: ObservableObject {
    @Published var shouldFinishLogin = false
    @Published var shouldShowErrorAlert = false

    @Published var errorTitle: String?
    @Published var errorMessage: String?

    init(userType: UserType) {
        self.userType = userType
    }

    private var student: Student?
    private var teacher: Teacher?
    private var userType: UserType

    func authorise(login: String, password: String) {
        switch userType {
        case .teacher:
            let result = ServerMock.authorizeTeacher(login: login, password: password)
            switch result {
            case .success(let student):
                self.student = student
                shouldFinishLogin = true
            case .failure(let error):
                if error == .wrongCredentials {
                    showErrorAlert(title: "Ошибка авторизация", messsage: "Пользователя с таким логином и паролем не существует")
                }
            }
        case .student:
            let result = ServerMock.authorizeStudent(login: login, password: password)
            switch result {
            case .success(let student):
                self.student = student
                shouldFinishLogin = true
            case .failure(let error):
                if error == .wrongCredentials {
                    showErrorAlert(title: "Ошибка авторизация", messsage: "Пользователя с таким логином и паролем не существует")
                }
            }
        }
    }

    var destination: AnyView? {
        switch userType {
        case .teacher:
            guard let teacher = teacher else {
                return nil
            }

            let accountViewModel = TeacherAccountViewModel(teacher: teacher)
            return AnyView(TeacherAccountScreen(viewModel: accountViewModel))
        case .student:
            guard let student = student else {
                return nil
            }

            let accountViewModel = StudentAccountViewModel(student: student)
            return AnyView(StudentAccountScreen(viewModel: accountViewModel))
        }
    }

    private func showErrorAlert(title: String, messsage: String) {
        errorTitle = title
        errorMessage = messsage
        shouldShowErrorAlert = true
    }
}
