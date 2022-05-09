import SwiftUI

struct TeacherAccountScreen: View {
    var body: some View {
        VStack {
            Image("teacher")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.top, 40)
                .padding(.bottom, 30)
            Text(viewModel.teacher.fullName)
                .font(.system(size: 40, weight: .medium))
                .padding(.bottom, 10)
            Text("Предмет: ")
                .font(.system(size: 20, weight: .medium))
            + Text(viewModel.teacher.subjectType.name.lowercased())
                .font(.system(size: 20))
            Text("Группы: ")
                .font(.system(size: 20, weight: .medium))
            + Text(
                viewModel.teacher.groups
                    .map { String($0.number) }
                    .joined(separator: ", ")
            )
                .font(.system(size: 20))

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

    init(viewModel: TeacherAccountViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }

    @ObservedObject private var viewModel: TeacherAccountViewModel
    @State private var shouldShowSchedule = false
    @Binding private var isPresented: Bool
}

struct TeacherAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherAccountScreen(
            viewModel: .init(
                teacher: Teacher.test
            ),
            isPresented: .just(value: true)
        )
    }
}

extension Teacher {
    static var test: Teacher {
        .init(
            fullName: "Тест Тестовый",
            groups: [],
            subjectType: .economics
        )
    }
}
