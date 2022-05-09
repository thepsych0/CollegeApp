import SwiftUI

extension Binding {
    static func just(value: Value) -> Binding<Value> {
        .init(
            get: { value },
            set: { _ in }
        )
    }
}
