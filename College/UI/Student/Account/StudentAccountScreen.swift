import SwiftUI

struct StudentAccountScreen: View {
    var body: some View {
        VStack {
            Image(viewModel.imageName)
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.top, 40)
                .padding(.bottom, 30)

            Text(viewModel.student.fullName)
                .font(.system(size: 40, weight: .medium))
                .padding(.bottom, 10)

            Text("Группа \(viewModel.student.groupNumber)")
                .font(.system(size: 30, weight: .medium))

            Button {
                shouldShowSchedule = true
            } label: {
                Text("Расписание")
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
            .fullScreenCover(
                isPresented: $shouldShowSchedule,
                content: {
                    viewModel.scheduleDestination(isPresented: $shouldShowSchedule)
                }
            )
            .padding()
            .padding(.bottom, 8)

            Button {
                isPresented = false
            } label: {
                Text("Выйти")
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(Color.red)
                        .frame(width: 200, height: 40)
                    )
            }

            Spacer()
        }
        .padding()
        
    }

    init(viewModel: StudentAccountViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }

    @ObservedObject private var viewModel: StudentAccountViewModel
    @State private var shouldShowSchedule = false
    @Binding private var isPresented: Bool
}

struct StudentAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentAccountScreen(
            viewModel: .init(
                student: Student.testMale
            ),
            isPresented: .just(value: true)
        )

        StudentAccountScreen(
            viewModel: .init(
                student: Student.testFemale
            ),
            isPresented: .just(value: true)
        )
    }
}

extension Student {
    static var testMale: Student {
        .init(
            login: "test",
            fullName: "Тест Тестовый",
            groupNumber: 121,
            gender: .male
        )
    }

    static var testFemale: Student {
        .init(
            login: "test",
            fullName: "Тестесса Тестовая",
            groupNumber: 122,
            gender: .female
        )
    }
}
