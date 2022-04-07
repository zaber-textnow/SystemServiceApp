//
//  SSBatteryInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit

class SSBatteryInfo: NSObject {

    static func batteryLevel()->Float {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        let batteryCharge = device.batteryLevel
        return batteryCharge > 0 ?  batteryCharge * 100.0 : -1
    }
    
    static func charging()->Bool {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        return device.batteryState == .charging || device.batteryState == .full
    }
    
    static func fullyCharged()->Bool {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        return device.batteryState == .full
    }
}
