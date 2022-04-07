//
//  SSMemoryInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit

class SSMemoryInfo: NSObject {
    
    static func totalMemory()->Double {
        var totalMemory : Double = 0.00;
        let allMemory : Double = Double(ProcessInfo.processInfo.physicalMemory);
        
        // Total Memory (formatted)
        totalMemory = (allMemory / 1024.0) / 1024.0
        
        // Round to the nearest multiple of 256mb - Almost all RAM is a multiple of 256mb (I do believe)
        let toNearest = 256
        let remainder = Int(totalMemory) % toNearest
        
        if remainder >= toNearest / 2 {
            // Round the final number up
            totalMemory = Double((Int(totalMemory) - remainder) + 256)
        } else {
            // Round the final number down
            totalMemory = Double(Int(totalMemory) - remainder)
        }
        
        // Check to make sure it's valid
        if totalMemory <= 0 {
            // Error, invalid memory value
            return -1;
        }
        
        // Completed Successfully
        return totalMemory
    }
    
    static func freeMemory(inPercent: Bool) ->Double? {
        let hostPort: mach_port_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        var pagesize:vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        
        let capacity = MemoryLayout.size(ofValue: vmStat) / MemoryLayout<Int32>.stride
        
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: capacity)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        // Now take a look at what we got and compare it against KERN_SUCCESS
        if status == KERN_SUCCESS {
            let memory = Double(vmStat.free_count * UInt32(pagesize)) / (1024.0 * 1024.0)
            return inPercent ? ((memory * 100.0) / totalMemory()) : memory
        }
        
        return nil
    }
    
    static func usedMemory(inPercent: Bool) ->Double? {
        let hostPort: mach_port_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        var pagesize:vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        
        let capacity = MemoryLayout.size(ofValue: vmStat) / MemoryLayout<Int32>.stride
        
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: capacity)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        // Now take a look at what we got and compare it against KERN_SUCCESS
        if status == KERN_SUCCESS {
            let memory = (Double((vm_size_t)(vmStat.active_count + vmStat.inactive_count + vmStat.wire_count)) / (1024.0 * 1024.0) ) * Double(pagesize)
            
            return inPercent ? ((memory * 100.0) / totalMemory()) : memory
        }
        
        return nil
    }
    
    static func activeMemory(inPercent: Bool) ->Double? {
        let hostPort: mach_port_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        var pagesize:vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        
        let capacity = MemoryLayout.size(ofValue: vmStat) / MemoryLayout<Int32>.stride
        
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: capacity)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        // Now take a look at what we got and compare it against KERN_SUCCESS
        if status == KERN_SUCCESS {
            let memory = (Double(vmStat.active_count) / (1024.0 * 1024.0)) * Double(pagesize)
            return inPercent ? ((memory * 100.0) / totalMemory()) : memory
        }
        
        return nil
    }
    
    static func inactiveMemory(inPercent: Bool) ->Double? {
        let hostPort: mach_port_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        var pagesize:vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        
        let capacity = MemoryLayout.size(ofValue: vmStat) / MemoryLayout<Int32>.stride
        
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: capacity)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        // Now take a look at what we got and compare it against KERN_SUCCESS
        if status == KERN_SUCCESS {
            let memory = (Double(vmStat.inactive_count) / (1024.0 * 1024.0)) * Double(pagesize)
            return inPercent ? ((memory * 100.0) / totalMemory()) : memory
        }
        
        return nil
    }
    
    static func wiredMemory(inPercent: Bool) ->Double? {
        let hostPort: mach_port_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        var pagesize:vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        
        let capacity = MemoryLayout.size(ofValue: vmStat) / MemoryLayout<Int32>.stride
        
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: capacity)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        // Now take a look at what we got and compare it against KERN_SUCCESS
        if status == KERN_SUCCESS {
            let memory = (Double(vmStat.wire_count) / (1024.0 * 1024.0)) * Double(pagesize)
            return inPercent ? ((memory * 100.0) / totalMemory()) : memory
        }
        
        return nil
    }
    
    static func purgableMemory(inPercent: Bool) ->Double? {
        let hostPort: mach_port_t = mach_host_self()
        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
        var pagesize:vm_size_t = 0
        host_page_size(hostPort, &pagesize)
        var vmStat: vm_statistics = vm_statistics_data_t()
        
        let capacity = MemoryLayout.size(ofValue: vmStat) / MemoryLayout<Int32>.stride
        
        let status: kern_return_t = withUnsafeMutableBytes(of: &vmStat) {
            
            let boundPtr = $0.baseAddress?.bindMemory(to: Int32.self, capacity: capacity)
            return host_statistics(hostPort, HOST_VM_INFO, boundPtr, &host_size)
        }
        // Now take a look at what we got and compare it against KERN_SUCCESS
        if status == KERN_SUCCESS {
            let memory = (Double(vmStat.purgeable_count) / (1024.0 * 1024.0)) * Double(pagesize)
            return inPercent ? ((memory * 100.0) / totalMemory()) : memory
        }
        
        return nil
    }
    
}

