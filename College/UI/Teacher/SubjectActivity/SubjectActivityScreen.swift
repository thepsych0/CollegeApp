import SwiftUI

struct SubjectActivityScreen: View {
    var body: some View {
        VStack {
            List {
                Section("Студенты") {
                    ForEach(viewModel.students, id: \.fullName) { student in
                        let activity = viewModel.activityDict[student]?.activity
                        VStack(alignment: .leading, spacing: 10) {
                            Text(student.fullName)
                                .font(.system(size: 20, weight: .medium))
                            if viewModel.week?.state != .future {
                                Toggle("Присутствовал(а):", isOn: wasPresent(student: student))
                                    .font(.system(size: 16))
                                if activity?.wasPresent ?? true {
                                    HStack {
                                        Text("Оценка:")
                                            .font(.system(size: 16))
                                        Spacer()
                                        if let mark = activity?.mark {
                                            Button(String(mark)) {
                                                selectedStudent = student
                                                showingAlert = true
                                            }
                                            .padding()
                                        } else {
                                            Button("Поставить") {
                                                selectedStudent = student
                                                showingAlert = true
                                            }
                                            .padding()
                                        }
                                    }
                                }
                            }
                        }
                        .listRowBackground(
                            viewModel.activityDict[student]?.activity?.wasPresent ?? true
                            ? Color(red: 0.94, green: 0.94, blue: 0.98)
                            : Color.red
                        )
                    }
                }
            }
            .sheet(isPresented: $showingAlert) {
                GiveMark(
                    action: { mark in
                        viewModel.setStudentMark(mark, for: selectedStudent!)
                    },
                    isPresented: $showingAlert
                )
            }
            .padding()

            Spacer()

            Text("Домашнее задание")
                .font(.system(size: 20, weight: .medium))

            TextField("Добавить", text: $viewModel.homeworkText)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .onSubmit {
                    guard !viewModel.homeworkText.isEmpty else { return }
                    viewModel.saveHomework()
                }
                .submitLabel(.done)
                .padding(.bottom, 12)

            Button() {
                viewModel.saveHomework()
            } label: {
                Text("Сохранить")
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
            .disabled(viewModel.homeworkText.isEmpty)
            .padding()
            .padding(.bottom, 80)
        }
        .navigationBarTitle(Text("Группа \(viewModel.group.number)"))
    }

    init(viewModel: SubjectActivityViewModel) {
        self.viewModel = viewModel
    }

    @ObservedObject private var viewModel: SubjectActivityViewModel
    @State private var showingAlert = false
    @State private var selectedStudent: Student?

    private func wasPresent(student: Student) -> Binding<Bool> {
        .init(
            get: {
                viewModel.activityDict[student]?.activity?.wasPresent ?? true
            },
            set: { wasPresent in
                saveActivity(student: student, wasPresent: wasPresent)
            }
        )
    }

    private func saveActivity(student: Student, wasPresent: Bool) {
        viewModel.setStudentPresence(wasPresent, for: student)
    }

    private var buttonColor: Color {
        return !viewModel.homeworkText.isEmpty
        ? Color.blue
        : Color.blue.opacity(0.5)
    }

}

struct SubjectActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
        SubjectActivityScreen(
            viewModel: .init(
                group:
                    Group(
                        number: 1,
                        schedule: [:]
                    ),
                date: Date(),
                slot: .slot1
            )
        )
    }
}
