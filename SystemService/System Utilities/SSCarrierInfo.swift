//
//  SSCarrierInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit
import CoreTelephony

class SSCarrierInfo: NSObject {
    
    static func carrierName()->String? {
        let tel = CTTelephonyNetworkInfo.init()
        return tel.subscriberCellularProvider?.carrierName
    }
    
    static func carrierCountry()->String? {
        let local = Locale.current as NSLocale
        return local.object(forKey: NSLocale.Key.countryCode) as? String
    }
    
    static func carrierMobileCountryCode()->String? {
        let tel = CTTelephonyNetworkInfo.init()
        return tel.subscriberCellularProvider?.mobileCountryCode
    }
    
    static func carrierISOCountryCode()->String? {
        let tel = CTTelephonyNetworkInfo.init()
        return tel.subscriberCellularProvider?.isoCountryCode
    }
    
    static func carrierMobileNetworkCode()->String? {
        let tel = CTTelephonyNetworkInfo.init()
        return tel.subscriberCellularProvider?.mobileNetworkCode
    }
    
    static func carrierAllowsVOIP()->Bool {
        let tel = CTTelephonyNetworkInfo.init()
        return tel.subscriberCellularProvider?.allowsVOIP ?? false
    }
    
    
}
