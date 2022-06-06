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

    private var authenticatedUser: AuthenticatedUser?
    private var userType: UserType

    func authorise(login: String, password: String) {
        switch userType {
        case .teacher:
            let result = ServerMock.authorizeTeacher(login: login, password: password)
            switch result {
            case .success(let teacher):
                self.authenticatedUser = .teacher(teacher)
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
                self.authenticatedUser = .student(student)
                shouldFinishLogin = true
            case .failure(let error):
                if error == .wrongCredentials {
                    showErrorAlert(title: "Ошибка авторизация", messsage: "Пользователя с таким логином и паролем не существует")
                }
            }
        case .admin:
            let result = ServerMock.authorizeAdmin(login: login, password: password)
            switch result {
            case .success:
                self.authenticatedUser = .admin
                shouldFinishLogin = true
            case .failure(let error):
                if error == .wrongCredentials {
                    showErrorAlert(title: "Ошибка авторизация", messsage: "Пользователя с таким логином и паролем не существует")
                }
            }
        }
    }

    func destination(isPresented: Binding<Bool>) -> AnyView? {
        switch userType {
        case .teacher:
            guard let teacher = authenticatedUser?.teacher else {
                return nil
            }

            let accountViewModel = TeacherAccountViewModel(teacher: teacher)
            return AnyView(TeacherAccountScreen(viewModel: accountViewModel, isPresented: isPresented))
        case .student:
            guard let student = authenticatedUser?.student else {
                return nil
            }

            let accountViewModel = StudentAccountViewModel(student: student)
            return AnyView(StudentAccountScreen(viewModel: accountViewModel, isPresented: isPresented))
        case .admin:
            guard let authenticatedUser = authenticatedUser else {
                return nil
            }

            switch authenticatedUser {
            case .admin:
                break
            default:
                return nil
            }

            let categoriesViewModel = SelectEditingCategoryViewModel()
            return AnyView(SelectEditingCategoryScreen(viewModel: categoriesViewModel, isPresented: isPresented))
        }
    }

    private func showErrorAlert(title: String, messsage: String) {
        errorTitle = title
        errorMessage = messsage
        shouldShowErrorAlert = true
    }

    private enum AuthenticatedUser {
        case teacher(_ user: Teacher)
        case student(_ user: Student)
        case admin

        var teacher: Teacher? {
            switch self {
            case .teacher(let teacher):
                return teacher
            default:
                return nil
            }
        }

        var student: Student? {
            switch self {
            case .student(let student):
                return student
            default:
                return nil
            }
        }
    }
}
