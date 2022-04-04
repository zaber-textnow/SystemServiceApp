//
//  SSHardwareInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit
import CoreMotion


class SSHardwareInfo: NSObject {

    static var sCachedIsProximityEnabled = false

    static func systemUptime() -> String {
        let uptimeInterval = ProcessInfo.processInfo.systemUptime
        let calendar = Calendar.current
        
        let date = Date.init(timeIntervalSinceNow: 0-uptimeInterval)
        let components = calendar.dateComponents([.day, .hour, .minute], from: date, to: Date())

        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let mins = components.minute ?? 0

        return String(format: "%dd %dh %dm", days, hours, mins)
    }
    
    static func deviceModel()-> String {
        return UIDevice.current.model
    }
    
    static func deviceName()-> String {
        return UIDevice.current.name
    }
    
    static func systemName()-> String {
        return UIDevice.current.systemName
    }
    
    static func systemVersion()-> String {
        return UIDevice.current.systemVersion
    }
    
    static func screenWidth()-> Int {
        return Int(UIScreen.main.bounds.width)
    }
    
    static func screenHeight()-> Int {
        return Int(UIScreen.main.bounds.height)
    }
    
    static func screenBrightness()-> Float {
        let bright = Float(UIScreen.main.brightness)
        return (bright < 0.0 || bright > 1.0) ? -1.0 : bright * 100.0
    }
    
    static func multitaskingEnabled()-> Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    
    static func proximitySensorEnabled()-> Bool {
        if Thread.isMainThread == false {
            return sCachedIsProximityEnabled
        }
        
        let device = UIDevice.current
        var  ProximitySensor = false

        // Turn the sensor on, if not already on, and see if it works
        if device.isProximityMonitoringEnabled == false {
            // Sensor is off
            // Turn it on
            device.isProximityMonitoringEnabled = true

            // See if it turned on
            if device.isProximityMonitoringEnabled {
                device.isProximityMonitoringEnabled = false
                ProximitySensor = true
            } else {
                // Didn't turn on, no good
                ProximitySensor = false
            }
        } else {
            ProximitySensor = true
        }

        sCachedIsProximityEnabled = ProximitySensor
        return ProximitySensor
    }
    
    static func pluggedIn()-> Bool {
        let device = UIDevice.current
        return device.batteryState == .charging || device.batteryState == .full
    }
    
    static func stepCountingAvailable()-> Bool {
        return CMPedometer.isStepCountingAvailable()
    }
    
    static func distanceAvailable()-> Bool {
        return CMPedometer.isDistanceAvailable()
    }
    
    static func floorCountingAvailable()-> Bool {
        return CMPedometer.isFloorCountingAvailable()
    }
    
    static func systemDeviceTypeFormatted(_ formatted: Bool)-> String {

        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
         
        if formatted {
            switch identifier {
            case "iPod1,1":                                 return "iPod Touch 1G"
            case "iPod2,1":                                 return "iPod Touch 2G"
            case "iPod3,1":                                 return "iPod Touch 3G"
            case "iPod4,1":                                 return "iPod Touch 4G"
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
                
            case "iPhone1,1":     return "iPhone 4"
            case "iPhone1,2":     return "iPhone 4"
            case "iPhone2,1":     return "iPhone 4"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1":                              return "iPhone 8"
            case "iPhone10,2":                              return "iPhone 8 Plus"
            case "iPhone10,3":                              return "iPhone X"
            case "iPhone10,4":                              return "iPhone 8 (GSM/LTE)"
            case "iPhone10,5":                              return "iPhone 8 Plus"
            case "iPhone10,6":                              return "iPhone X"
            case "iPhone11.2":                              return "iPhone XS"
            case "iPhone11.4":                              return "iPhone XS MAX"
            case "iPhone11,6":                              return "iPhone XS MAX (CDMA+GSM/LTE)"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                               return "iPhone 11"
            case "iPhone12,3":                               return "iPhone 11 Pro"
            case "iPhone12,5":                               return "iPhone 11 Pro Max"
            case "iPhone13,1":                               return "iPhone 12 mini"
            case "iPhone13,2":                               return "iPhone 12"
            case "iPhone13,3":                               return "iPhone 12 Pro"
            case "iPhone13,4":                               return "iPhone 12 Pro Max"
            case "iPhone14,4":                               return "iPhone 13 mini"
            case "iPhone14,5":                               return "iPhone 13"
            case "iPhone14,2":                               return "iPhone 13 Pro"
            case "iPhone14,3":                               return "iPhone 13 Pro Max"
            case "iPhone15,1", "iPhone15,21", "iPhone15,3", "iPhone15,4": return "iPhone 14"
            case "iPhone8,4":                               return "iPhone SE"
            case "AppleTV5,3":                              return "Apple TV"
            case "i386", "x86_64":                          return "Simulator"
            default:                                        return identifier
            }
        }
        else {
            return identifier
        }
        
        
      

    }
    
   
}
