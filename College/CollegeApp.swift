import SwiftUI

import RealmSwift

@main
struct CollegeApp: SwiftUI.App {

    init() {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes {
            (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
    
        let config = Realm.Configuration(encryptionKey: Realm.Encryption.getKey(), schemaVersion: 5)
        Realm.Configuration.defaultConfiguration = config
    }

    var body: some Scene {
        WindowGroup {
            StartScreen()
        }
    }
}
