import SwiftUI

struct StartScreen: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("Войти как:")
                    .font(.system(size: 40, weight: .medium))
                    .padding(.bottom, 30)

                ForEach(
                    [
                        UserType.teacher,
                        UserType.student
                    ],
                    id: \.self
                ) { userType in
                    NavigationLink(
                        destination: LoginScreen(
                            viewModel: .init(userType: userType)
                        )
                    ) {
                        Text(userType.rawValue)
                            .foregroundColor(Color.white)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous
                                )
                                .fill(Color.blue)
                                .frame(width: 200, height: 40)
                            )
                    }
                    .padding()
                }
            }
            .padding()
        }
    }

    @ObservedObject private var viewModel = StartViewModel()
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
