//
//  SSJailbreakCheck.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit

enum JailbrokenChecks : Int {
    case jailBroken = 3429542
    case openURL = 321
    case cydia = 432
    case ifc = 47293
    case plist = 9412
    case symbolic = 34859
    case fileExists = 6625
    case notJail = 4783242
}
 
let CYDIAPACKAGE = "cydia://package/com.fake.package"
let CYDIALOC = "/Applications/Cydia.app"
let HIDDENFILES = ["/Applications/RockApp.app",
                   "/Applications/Icy.app",
                   "/usr/sbin/sshd",
                   "/usr/bin/sshd",
                   "/usr/libexec/sftp-server",
                   "/Applications/WinterBoard.app",
                   "/Applications/SBSettings.app",
                   "/Applications/MxTube.app",
                   "/Applications/IntelliScreen.app",
                   "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                   "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                   "/private/var/lib/apt",
                   "/private/var/stash",
                   "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                   "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                   "/private/var/tmp/cydia.log",
                   "/private/var/lib/cydia",
                   "/etc/clutch.conf",
                   "/var/cache/clutch.plist",
                   "/etc/clutch_cracked.plist",
                   "/var/cache/clutch_cracked.plist",
                   "/var/lib/clutch/overdrive.dylib",
                   "/var/root/Documents/Cracked/"]



class SSJailbreakCheck: NSObject {

    static func jailbroken()->Bool {
        // Make an int to monitor how many checks are failed
        var motzart = 0;
        
        // Check if iOS 8 or lower
        if #available(iOS 9.0, *) {} else {
            if urlCheck() != .notJail {
                motzart += 3
            }
        }
      
        
        // Cydia Check
        if cydiaCheck() != .notJail {
            // Jailbroken
            motzart += 3
        }
        
        // Inaccessible Files Check
        if inaccessibleFilesCheck() != .notJail {
            // Jailbroken
            motzart += 2
        }
        
        // Plist Check
        if plistCheck() != .notJail {
            // Jailbroken
            motzart += 2
        }
        
        // FilesExist Integrity Check
        if filesExistCheck() != .notJail {
            // Jailbroken
            motzart += 2
        }
        
        if motzart >= 3 {
            // Jailbroken
            return true
        }
        
        // Not Jailbroken
        return false
    }
    
    private class func urlCheck()->JailbrokenChecks {
        if let url = URL(string: CYDIAPACKAGE), UIApplication.shared.canOpenURL(url) {
            return .openURL
        }
        
        return . notJail
    }
    
    private class func cydiaCheck()->JailbrokenChecks {
        if FileManager.default.fileExists(atPath: CYDIALOC) {
            return .cydia
        }
        
        return . notJail
    }
    
    private class func inaccessibleFilesCheck()->JailbrokenChecks {
        for file in HIDDENFILES {
            if FileManager.default.fileExists(atPath: file) {
                return .ifc
            }
        }
        
        return . notJail
    }
    
    private class func plistCheck()->JailbrokenChecks {
        if FileManager.default.fileExists(atPath: Bundle.main.executablePath ?? "") == false {
            return .plist
        }
        
        guard let dic = Bundle.main.infoDictionary, dic.count > 0 else {
            return .plist
        }
        
        return . notJail
    }
    
   
    private class func filesExistCheck()->JailbrokenChecks {
        if FileManager.default.fileExists(atPath: Bundle.main.executablePath ?? "") == false {
            return .fileExists
        }
        
        return . notJail
    }
    
}

