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
            Text(viewModel.teacher.subjectType.rawValue)
                .font(.system(size: 30, weight: .medium))
            Spacer()
        }
        .padding()
    }

    init(viewModel: TeacherAccountViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: TeacherAccountViewModel
}

struct TeacherAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        TeacherAccountScreen(
            viewModel: .init(
                teacher: Teacher.test
            )
        )
    }
}

extension Teacher {
    static var test: Teacher {
        .init(
            fullName: "Тест Тестовый",
            groups: ["121"],
            subjectType: .programming
        )
    }
}
