import SwiftUI

struct EditTeachersScreen: View {
    var body: some View {
        VStack(spacing: 40) {
            List {
                ForEach(viewModel.teachers, id: \.fullName) { teacher in
                    Text(teacher.fullName)
                }
                .onDelete(perform: delete)
            }

            NavigationLink(destination: viewModel.createTeacherView) {
                Text("Добавить")
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .fill(Color.blue)
                        .frame(width: 200, height: 60)
                    )
                    .font(.system(size: 20, weight: .bold))
            }
            .padding()
            .padding(.bottom, 40)
        }
        .onAppear {
            viewModel.update()
        }
        .padding(.top, 12)
        .navigationTitle("Преподаватели")
    }

    init(viewModel: EditTeachersViewModel) {
        self.viewModel = viewModel
    }

    func delete(at offsets: IndexSet) {
        viewModel.removeTeacher(at: offsets)
    }

    @ObservedObject private var viewModel: EditTeachersViewModel
}

struct EditTeachersScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditTeachersScreen(viewModel: .init())
    }
}
