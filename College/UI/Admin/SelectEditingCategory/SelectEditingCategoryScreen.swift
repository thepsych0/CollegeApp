import SwiftUI

struct SelectEditingCategoryScreen: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("Выберите категорию для редактирования")
                    .font(.system(size: 20, weight: .medium))
                    .padding(.bottom, 30)

                ForEach(
                    [
                        UserType.teacher,
                        UserType.student,
                    ],
                    id: \.self
                ) { userType in
                    NavigationLink(
                        destination: viewModel.destination(for: userType)
                    ) {
                        Text(categoryName(for: userType))
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
            .toolbar {
                Button(
                    action: {
                        isPresented = false
                    }
                ) {
                    Image(systemName: "xmark")
                }
            }
            .padding()
        }
    }

    private func categoryName(for userType: UserType) -> String {
        switch userType {
        case .teacher:
            return "Преподаватели"
        case .student:
            return "Студенты"
        case .admin:
            assertionFailure()
            return ""
        }
    }

    init(viewModel: SelectEditingCategoryViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }

    @ObservedObject private var viewModel: SelectEditingCategoryViewModel
    @Binding private var isPresented: Bool
}

struct SelectEditingCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectEditingCategoryScreen(
            viewModel: .init(),
            isPresented: .just(value: true)
        )
    }
}
