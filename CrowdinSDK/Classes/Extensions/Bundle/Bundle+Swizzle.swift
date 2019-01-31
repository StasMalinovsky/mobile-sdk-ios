//
//  UILabel.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 1/23/19.
//

import Foundation
import UIKit

extension Bundle {
    static var original: Method!
    static var swizzled: Method!
    
    @objc func swizzled_LocalizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        var translation = Localization.current.localization[key]
        if translation == nil {
            translation = swizzled_LocalizedString(forKey: key, value: value, table: tableName)
        }
        return translation ?? key;
    }

    
    public class func swizzle() {
        original = class_getInstanceMethod(self, #selector(Bundle.localizedString(forKey:value:table:)))!
        swizzled = class_getInstanceMethod(self, #selector(Bundle.swizzled_LocalizedString(forKey:value:table:)))!
        method_exchangeImplementations(original, swizzled)
    }
    
    public class func unswizzle() {
        guard original != nil && swizzled != nil else { return }
        method_exchangeImplementations(swizzled, original)
    }
}
