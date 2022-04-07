//
//  SSLocalizationInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit

class SSLocalizationInfo: NSObject {

    static func country()->String {
        return Locale.current.identifier
    }
    
    static func language()->String? {
        return Locale.preferredLanguages.first
    }
    
    static func timeZone()->String {
        return NSTimeZone.system.identifier
    }
    
    static func currency()->String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.currencySymbol) as? String
    }
}
