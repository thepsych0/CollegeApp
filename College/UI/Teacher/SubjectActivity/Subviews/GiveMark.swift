import SwiftUI

struct GiveMark: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Поставить оценку")
                .font(.system(size: 24, weight: .medium))
                .padding(.top, 80)
            Text("по пятибальной шкале")
                .font(.system(size: 20))
                .padding(.bottom, 20)
            TextField("Оценка", text: $text)
                .keyboardType(.numberPad)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 80)
                .padding(.bottom, 20)
            Button {
                guard let mark = Int(text), 0...5 ~= mark else {
                    return
                }
                action(mark)
                isPresented = false
            } label: {
                Text("Готово")
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
            Button {
                isPresented = false
            } label: {
                Text("Отмена")
                    .foregroundColor(Color.blue)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                        .stroke(Color.blue, lineWidth: 2)
                        .frame(width: 200, height: 40)
                    )
            }
            .padding(.top, 12)
            Spacer()
        }
    }

    init(action: @escaping (Int) -> Void, isPresented: Binding<Bool>) {
        self.action = action
        self._isPresented = isPresented
    }

    private let action: (Int) -> Void

    @State private var text: String = ""
    @Binding private var isPresented: Bool
}

struct GiveMark_Previews: PreviewProvider {
    static var previews: some View {
        GiveMark(
            action: { _ in },
            isPresented: .just(value: true)
        )
    }
}
