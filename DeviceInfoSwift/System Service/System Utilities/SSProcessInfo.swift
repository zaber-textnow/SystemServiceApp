//
//  SSProcessInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit

class SSProcessInfo: NSObject {
    
    static func processID()->Int {
        let pid = getpid()
        return pid <= 0 ? -1 : Int(pid)
    }
    
}
