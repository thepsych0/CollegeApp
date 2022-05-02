import SwiftUI

struct LoginScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Авторизация")
                .font(.system(size: 40, weight: .medium))
                .padding(.bottom, 30)

            TextField("Логин", text: $username)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 12)

            SecureField("Пароль", text: $password)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.bottom, 30)

            Button {
                viewModel.authorise(login: username, password: password)
            } label: {
                Text("Войти")
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(buttonColor)
                        .frame(width: 200, height: 40)
                    )
            }
            .fullScreenCover(
                isPresented: $viewModel.shouldFinishLogin,
                content: {
                    viewModel.destination
                }
            )
            .padding()
        }
        .alert(
            viewModel.errorTitle ?? "",
            isPresented: $viewModel.shouldShowErrorAlert,
            actions: {
                Button("Закрыть", role: .cancel) {}
            },
            message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
        )
        .padding()
    }

    @State private var username = "student1"
    @State private var password = "pass1"

    private var allFieldsFilled: Bool {
        return !username.isEmpty && !password.isEmpty
    }

    private var buttonColor: Color {
        return allFieldsFilled ? Color.blue : Color.blue.opacity(0.5)
    }

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: LoginViewModel
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(viewModel: .init(userType: .teacher))
    }
}
