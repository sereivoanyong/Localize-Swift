//
//  String+LocalizedBundleTableName.swift
//  Localize_Swift
//
//  Copyright © 2020 Roy Marmelstein. All rights reserved.
//

import Foundation

/// bundle & tableName friendly extension
extension String {
    
    /**
     Swift 2 friendly localization syntax, replaces NSLocalizedString.
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: The localized string.
     */
    public func localized(using tableName: String? = nil, in bundle: Bundle? = nil) -> String {
        let bundle: Bundle = bundle ?? .main
        if let path = bundle.path(forResource: Localize.currentLanguage(), ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        else if let path = bundle.path(forResource: LCLBaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        return self
    }
    
    /**
     Swift 2 friendly localization syntax with format arguments, replaces String(format:NSLocalizedString).
     
     - parameter arguments: arguments values for temlpate (substituted according to the user’s default locale).
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.strings`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: The formatted localized string with arguments.
     */
    @inlinable
    public func localizedFormat(_ arguments: CVarArg..., using tableName: String? = nil, in bundle: Bundle? = nil) -> String {
        String(format: localized(using: tableName, in: bundle), arguments: arguments)
    }
    
    /**
     Swift 2 friendly plural localization syntax with a format argument.
     
     - parameter argument: Argument to determine pluralisation.
     
     - parameter tableName: The receiver’s string table to search. If tableName is `nil`
     or is an empty string, the method attempts to use `Localizable.stringsdict`.
     
     - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
     the method attempts to use main bundle.
     
     - returns: Pluralized localized string.
     */
    @inlinable
    public func localizedPlural(_ argument: CVarArg, using tableName: String? = nil, in bundle: Bundle? = nil) -> String {
        .localizedStringWithFormat(localized(using: tableName, in: bundle), argument)
    }
}
