//
//  SSAccessoryInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit
import AVFoundation
import ExternalAccessory

class SSAccessoryInfo: NSObject {

    static func accessoriesAttached()->Bool{
        return EAAccessoryManager.shared().connectedAccessories.count > 0
    }
    
    static func headphonesAttached()->Bool{
        let outputs = AVAudioSession.sharedInstance().currentRoute.outputs
        
        for output in outputs {
            if output.portType == .headphones {
                return true
            }
        }
        
        return false
    }
    
    static func numberAttachedAccessories()->Int {
        return EAAccessoryManager.shared().connectedAccessories.count
    }
    
    static func nameAttachedAccessories()->String? {
       let accessories = EAAccessoryManager.shared().connectedAccessories
        
        if accessories.isEmpty { return nil }
        
        var allAccessoryNames = [String]()
        
        for accessory in accessories {
            allAccessoryNames.append(accessory.name.count > 0 ? accessory.name : (accessory.manufacturer.count > 0 ? accessory.manufacturer : "Unknown" ))
        }
        
        if allAccessoryNames.isEmpty { return nil}

        return allAccessoryNames.joined(separator: ", ")
    }
    
}
