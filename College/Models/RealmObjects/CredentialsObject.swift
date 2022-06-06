import RealmSwift

typealias Credentials = CredentialsObject

final class CredentialsObject: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""

    override init() {}

    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
