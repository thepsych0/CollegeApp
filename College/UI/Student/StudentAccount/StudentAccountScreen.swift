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
            Text("Группа \(viewModel.student.group)")
                .font(.system(size: 30, weight: .medium))
            Button {
                viewModel.didTapScheduleButton()
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
                isPresented: $viewModel.shouldShowSchedule,
                content: {
                    viewModel.scheduleDestination
                }
            )
            .padding()
            Spacer()
        }
        .padding()
        
    }

    init(viewModel: StudentAccountViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: StudentAccountViewModel
}

struct StudentAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        StudentAccountScreen(
            viewModel: .init(
                student: Student.testMale
            )
        )

        StudentAccountScreen(
            viewModel: .init(
                student: Student.testFemale
            )
        )
    }
}

extension Student {
    static var testMale: Student {
        .init(
            fullName: "Тест Тестовый",
            group: "121",
            gender: .male
        )
    }

    static var testFemale: Student {
        .init(
            fullName: "Тестесса Тестовая",
            group: "121Б",
            gender: .female
        )
    }
}
