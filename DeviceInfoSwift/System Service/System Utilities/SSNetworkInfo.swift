//
//  SSNetworkInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 2/4/22.
//

import UIKit


class SSNetworkInfo: NSObject {
    
    static func currentIPAddress()->String? {
        if connectedToWiFi() {
            return wiFiIPAddress()
        }
        else if connectedToCellNetwork() {
            return cellIPAddress()
        }
        else {
            return nil
        }
    }
    
    static func externalIPAddress()->String? {
        if connectedToCellNetwork() == false && connectedToWiFi() == false {
            return nil
        }
       
        else if let url = URL(string: "https://icanhazip.com/") {
            do {
                let externalIP = try String(contentsOf: url)
                return externalIP.trimmingCharacters(in: .newlines)
            }
            catch _ { }
        }
        
        return nil
    }

    static func cellIPAddress()->String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) {
                    let name: String = String(cString: (interface.ifa_name))
                                        
                    if  name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            
            freeifaddrs(ifaddr)
        }
        
        return address ?? ""
    }
    
    static func cellIPv6Address()->String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET6) {
                    let name: String = String(cString: (interface.ifa_name))
                                        
                    if  name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            
            freeifaddrs(ifaddr)
        }
        
        return address ?? ""
    }
    
    static func cellBroadcastAddress()->String? {
        
        let ipAddress = cellIPAddress()
        let nmAddress: String? = "255.255.255.0"

        if ipAddress == nil || ipAddress!.count == 0 {
            return nil
        }
        
        if nmAddress == nil || nmAddress!.count == 0 {
            return nil
        }
        
        let ipCheck = ipAddress!.components(separatedBy: ".")
        let nmCheck = nmAddress!.components(separatedBy: ".")

        if ipCheck.count != 4 || nmCheck.count != 4 {
            // Incorrect IP Addresses
            return nil
        }
        
        // Set up the variables
        var ip = 0;
        var nm = 0;
        var cs = 24;
        
        for i in 0..<4 {
            ip |= (Int(ipCheck[i]) ?? 0) << cs
            nm |= (Int(nmCheck[i]) ?? 0)  << cs
            cs -= 8
        }
        
        let ba = ~nm | ip
        
        return String(format: "%lu.%lu.%lu.%lu", Int64(ba & 0xFF000000) >> 24, Int64(ba & 0x00FF0000) >> 16, Int64(ba & 0x0000FF00) >> 8, Int64(ba & 0x000000FF))
  
    }
   
 
   
    static func wiFiIPAddress()->String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) {
                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            
            freeifaddrs(ifaddr)
        }
        
        return address ?? ""
    }
    
    static func wiFiIPv6Address()->String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET6) {
                    
                    
                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            
            freeifaddrs(ifaddr)
        }
        
        return address ?? ""
    }
    
    
    static func wiFiBroadcastAddress()->String? {
        
        let ipAddress = wiFiIPAddress()
        let nmAddress: String? = "255.255.255.0"

        if ipAddress == nil || ipAddress!.count == 0 {
            return nil
        }
        
        if nmAddress == nil || nmAddress!.count == 0 {
            return nil
        }
        
        let ipCheck = ipAddress!.components(separatedBy: ".")
        let nmCheck = nmAddress!.components(separatedBy: ".")

        if ipCheck.count != 4 || nmCheck.count != 4 {
            // Incorrect IP Addresses
            return nil
        }
        
        // Set up the variables
        var ip = 0;
        var nm = 0;
        var cs = 24;
        
        for i in 0..<4 {
            ip |= (Int(ipCheck[i]) ?? 0) << cs
            nm |= (Int(nmCheck[i]) ?? 0)  << cs
            cs -= 8
        }
        
        let ba = ~nm | ip
        
        return String(format: "%lu.%lu.%lu.%lu", Int64(ba & 0xFF000000) >> 24, Int64(ba & 0x00FF0000) >> 16, Int64(ba & 0x0000FF00) >> 8, Int64(ba & 0x000000FF))
  
    }
    
    
    static func connectedToWiFi()->Bool{
        let add = wiFiIPAddress()
        return add != nil && add!.count > 0
    }
    
    static func connectedToCellNetwork()->Bool{
        let add = cellIPAddress()
        return add != nil && add!.count > 0
    }


    
    //    if addrFamily == UInt8(AF_INET) {
    //        if addrFamily == UInt8(AF_INET6) {
    
    //    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
    
    // wifi = ["en0"]
    // wired = ["en2", "en3", "en4"]
    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
    
    
}



