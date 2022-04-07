//
//  SSDiskInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit

class SSDiskInfo: NSObject {
    
    static func diskSpace()->String? {
        guard let space = longDiskSpace() else { return nil }
        return formatMemory(space)
    }
    
    static func freeDiskSpace(inPercent: Bool)->String? {
        guard let space = longFreeDiskSpace() else { return nil }
        
        if inPercent {
            guard let totalSpace = longDiskSpace() else { return nil }
            if totalSpace <= 0 { return nil }
            let percentDiskSpace = (Double(space) * 100.0) / Double(totalSpace);
            return String(format: "%.2f %%", percentDiskSpace)
        }
        else {
            return formatMemory(space)
        }
    }
    
    static func usedDiskSpace(inPercent: Bool)->String? {
        guard let tds = longDiskSpace(), let fds = longFreeDiskSpace() else { return nil }
        
        let  uds = tds - fds
        if uds <= 0 { return nil }
        
        if (inPercent) {
            let percentUsedDiskSpace = (Double(uds) * 100.0) / Double(tds);
            return String(format: "%.2f %%", percentUsedDiskSpace)
            
        } else {
            return formatMemory(uds)
        }
        
    }
    
    
    static func longDiskSpace()->Int64? {
        do {
            let fileAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            let diskSpace = fileAttributes[FileAttributeKey.systemSize] as? Int64 ?? 0
            return  diskSpace <= 0 ? nil : diskSpace
        }
        catch _ {
            return nil
        }
    }
    
    static func longFreeDiskSpace()->Int64? {
        do {
            let fileAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            let diskSpace = fileAttributes[FileAttributeKey.systemFreeSize] as? Int64 ?? 0
            return  diskSpace <= 0 ? nil : diskSpace
        }
        catch _ {
            return nil
        }
    }
    
    static func formatMemory(_ space: Int64)->String? {
        return ByteCountFormatter.string(fromByteCount: space, countStyle: .file)
    }
    
    
    
}
