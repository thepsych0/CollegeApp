import SwiftUI

struct EditStudentsScreen: View {
    var body: some View {
        VStack(spacing: 40) {
            List {
                ForEach(viewModel.students, id: \.login) { student in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(student.fullName)
                            .font(.system(size: 20, weight: .medium))
                        Text("Группа: \(student.groupNumber)")
                            .font(.system(size: 16))
                    }
                }
                .onDelete(perform: delete)
            }

            NavigationLink(destination: viewModel.createStudentView) {
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
        .padding(.top, 12)
        .navigationTitle("Студенты")
        .onAppear {
            viewModel.update()
        }
    }

    func delete(at offsets: IndexSet) {
        viewModel.removeStudent(at: offsets)
    }

    init(viewModel: EditStudentsViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: EditStudentsViewModel
}

struct EditStudentsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditStudentsScreen(viewModel: .init())
    }
}
