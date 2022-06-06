import SwiftUI

struct TeacherInfoScreen: View {
    var body: some View {
        Form {
            Section("Данные для авторизациия") {
                TextField("Логин", text: $viewModel.login)
                    .textInputAutocapitalization(.never)
                SecureField("Пароль", text: $viewModel.password)
                    .textContentType(.newPassword)
                SecureField("Пароль повторно", text: $viewModel.passwordRepeated)
                    .textContentType(.newPassword)
            }

            Section("Личная информация") {
                TextField("Имя и фамилия", text: $viewModel.fullName)
            }

            Section("Учебная информация") {
                Picker("Предмет", selection: $viewModel.subjectTypeRawValue) {
                    ForEach(viewModel.availableSubjects, id: \.rawValue) {
                        Text($0.name).tag($0.rawValue)
                    }
                }
            }

            Button("Сохранить") {
                saveError = viewModel.save()

                guard saveError == nil else {
                    isAlertPresented = true
                    return
                }

                mode.wrappedValue.dismiss()
            }
            .alert(
                "Ошибка сохранения",
                isPresented: $isAlertPresented,
                actions: {
                    Button("Закрыть", role: .cancel) {
                        //saveError = nil
                    }
                },
                message: {
                    if let saveError = saveError {
                        Text(saveError)
                    }
                }
            )
        }
    }

    init(viewModel: TeacherInfoViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: TeacherInfoViewModel

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var isAlertPresented = false
    @State private var saveError: String?
}

struct TeacherInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherInfoScreen(viewModel: .init())
    }
}
