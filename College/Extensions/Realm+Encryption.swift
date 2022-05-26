import RealmSwift

extension Realm {
    enum Encryption {
        static func getKey() -> Data {
            let keychainIdentifier = "io.Realm.EncryptionKey"
            let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            // First check in the keychain for an existing key
            var query: [NSString: AnyObject] = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
                kSecAttrKeySizeInBits: 512 as AnyObject,
                kSecReturnData: true as AnyObject
            ]

            var dataTypeRef: AnyObject?
            var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
            if status == errSecSuccess {
                return dataTypeRef as! Data
            }

            var key = Data(count: 64)
            key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
                let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
                assert(result == 0, "Failed to get random bytes")
            })

            query = [
                kSecClass: kSecClassKey,
                kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
                kSecAttrKeySizeInBits: 512 as AnyObject,
                kSecValueData: key as AnyObject
            ]
            status = SecItemAdd(query as CFDictionary, nil)
            assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
            return key
        }
    }
}
