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
    
        let config = Realm.Configuration(encryptionKey: Realm.Encryption.getKey(), schemaVersion: 7)
        Realm.Configuration.defaultConfiguration = config

        if !UserDefaults.standard.bool(forKey: "notFirstLaunch") {
            injectInitialData()
        }

        UserDefaults.standard.set(true, forKey: "notFirstLaunch")
    }

    private func injectInitialData() {
        ServerDatabaseMock.Students.injectInitialStudents()
        ServerDatabaseMock.Teachers.injectInitialTeachers()
    }

    var body: some Scene {
        WindowGroup {
            StartScreen()
        }
    }
}
