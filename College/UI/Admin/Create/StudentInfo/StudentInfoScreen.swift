import SwiftUI

struct StudentInfoScreen: View {
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
                Picker("Пол", selection: $viewModel.genderRawValue) {
                    Text("Мужской").tag(Gender.male.rawValue)
                    Text("Женский").tag(Gender.female.rawValue)
                }
            }

            Section("Учебная информация") {
                Picker("Группа", selection: $viewModel.groupNumber) {
                    ForEach(viewModel.availableGroups, id: \.self) {
                        Text($0)
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

    init(viewModel: StudentInfoViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: StudentInfoViewModel

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var isAlertPresented = false
    @State private var saveError: String?
}

struct StudentInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentInfoScreen(viewModel: .init())
    }
}
