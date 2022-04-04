//
//  SystemService.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit

class SystemService: NSObject {

    static let shared = SystemService()


    private override init() { super.init() }
    

    
    func systemUptime()->String {
        return SSHardwareInfo.systemUptime()
    }
    
    func deviceModel()->String {
        return SSHardwareInfo.deviceModel()
    }
    
    func deviceName()->String {
        return SSHardwareInfo.deviceName()
    }
    
    func systemName()->String {
        return SSHardwareInfo.systemName()
    }
    
    func systemsVersion()->String {
        return SSHardwareInfo.systemVersion()
    }
    
    func systemDeviceTypeNotFormatted()->String {
        return SSHardwareInfo.systemDeviceTypeFormatted(false)
    }
    
    func systemDeviceTypeFormatted()->String {
        return SSHardwareInfo.systemDeviceTypeFormatted(true)
    }
    
    func screenWidth()->Int {
        return SSHardwareInfo.screenWidth()
    }
    
    func screenHeight()->Int {
        return SSHardwareInfo.screenHeight()
    }
    func screenBrightness()->Float {
        return SSHardwareInfo.screenBrightness()
    }
    
    func multitaskingEnabled()->Bool {
        return SSHardwareInfo.multitaskingEnabled()
    }
    
    func proximitySensorEnabled()->Bool {
        return SSHardwareInfo.proximitySensorEnabled()
    }
    
    func pluggedIn()->Bool {
        return SSHardwareInfo.pluggedIn()
    }
    
    func stepCountingAvailable()->Bool {
        return SSHardwareInfo.stepCountingAvailable()
    }
    
    func distanceAvailable()->Bool {
        return SSHardwareInfo.distanceAvailable()
    }
    
    func floorCountingAvailable()->Bool {
        return SSHardwareInfo.floorCountingAvailable()
    }

    func jailbroken()->Bool {
        return SSJailbreakCheck.jailbroken()
    }

    func numberProcessors()->Int {
        return SSProcessorInfo.numberProcessors()
    }
    
    func numberActiveProcessors()->Int {
        return SSProcessorInfo.numberActiveProcessors()
    }
    
    func processorsUsage()->[Double] {
        return SSProcessorInfo.processorsUsage()
    }

    func accessoriesAttached()->Bool {
        return SSAccessoryInfo.accessoriesAttached()
    }
    
    func headphonesAttached()->Bool {
        return SSAccessoryInfo.headphonesAttached()
    }
    
    func numberAttachedAccessories()->Int {
        return SSAccessoryInfo.numberAttachedAccessories()
    }
    
    func nameAttachedAccessories()->String? {
        return SSAccessoryInfo.nameAttachedAccessories()
    }

    
    
    func carrierName()->String? {
        return SSCarrierInfo.carrierName()
    }
    
    func carrierCountry()->String? {
        return SSCarrierInfo.carrierCountry()
    }
    
    func carrierMobileCountryCode()->String? {
        return SSCarrierInfo.carrierMobileCountryCode()
    }
    
    func carrierISOCountryCode()->String? {
        return SSCarrierInfo.carrierISOCountryCode()
    }
    
    func carrierMobileNetworkCode()->String? {
        return SSCarrierInfo.carrierMobileNetworkCode()
    }
    
    func carrierAllowsVOIP()->Bool {
        return SSCarrierInfo.carrierAllowsVOIP()
    }

    
    
    func batteryLevel()->Float {
        return SSBatteryInfo.batteryLevel()
    }
    
    func charging()->Bool {
        return SSBatteryInfo.charging()
    }
    
    func fullyCharged()->Bool {
        return SSBatteryInfo.fullyCharged()
    }
    
    
    
    func currentIPAddress()->String? {
        return SSNetworkInfo.currentIPAddress()
    }
    
    func externalIPAddress()->String? {
        return SSNetworkInfo.externalIPAddress()
    }
    
    func cellIPAddress()->String? {
        return SSNetworkInfo.cellIPAddress()
    }
    
    func cellBroadcastAddress()->String? {
        return SSNetworkInfo.cellBroadcastAddress()
    }
    
    func wiFiIPAddress()->String? {
        return SSNetworkInfo.wiFiIPAddress()
    }
    
    func wiFiBroadcastAddress()->String? {
        return SSNetworkInfo.wiFiBroadcastAddress()
    }
        
    func connectedToWiFi()->Bool {
        return SSNetworkInfo.connectedToWiFi()
    }
    
    func connectedToCellNetwork()->Bool {
        return SSNetworkInfo.connectedToCellNetwork()
    }
    
    
    func processID()->Int {
        return SSProcessInfo.processID()
    }
    
    
    
    func diskSpace()->String? {
        return SSDiskInfo.diskSpace()
    }
    
    func freeDiskSpaceinRaw()->String? {
        return SSDiskInfo.freeDiskSpace(inPercent: false)
    }
    
    func freeDiskSpaceinPercent()->String? {
        return SSDiskInfo.freeDiskSpace(inPercent: true)
    }
    
    func usedDiskSpaceinRaw()->String? {
        return SSDiskInfo.usedDiskSpace(inPercent: false)
    }
    
    func usedDiskSpaceinPercent()->String? {
        return SSDiskInfo.usedDiskSpace(inPercent: true)
    }
    
    func longDiskSpace()->Int64? {
        return SSDiskInfo.longDiskSpace()
    }
    
    func longFreeDiskSpace()->Int64? {
        return SSDiskInfo.longFreeDiskSpace()
    }
    
    
    
    func totalMemory()->Double? {
        return SSMemoryInfo.totalMemory()
    }
    
    func freeMemoryinRaw()->Double? {
        return SSMemoryInfo.freeMemory(inPercent: false)
    }
    
    func freeMemoryinPercent()->Double? {
        return SSMemoryInfo.freeMemory(inPercent: true)
    }
    
    func usedMemoryinRaw()->Double? {
        return SSMemoryInfo.usedMemory(inPercent: false)
    }
    
    func usedMemoryinPercent()->Double? {
        return SSMemoryInfo.usedMemory(inPercent: true)
    }
    
    func activeMemoryinRaw()->Double? {
        return SSMemoryInfo.activeMemory(inPercent: false)
    }
    
    func activeMemoryinPercent()->Double? {
        return SSMemoryInfo.activeMemory(inPercent: true)
    }
    
    func inactiveMemoryinRaw()->Double? {
        return SSMemoryInfo.inactiveMemory(inPercent: false)
    }
    
    func inactiveMemoryinPercent()->Double? {
        return SSMemoryInfo.inactiveMemory(inPercent: true)
    }
    
    func wiredMemoryinRaw()->Double? {
        return SSMemoryInfo.wiredMemory(inPercent: false)
    }
    
    func wiredMemoryinPercent()->Double? {
        return SSMemoryInfo.wiredMemory(inPercent: true)
    }
    
    func purgableMemoryinRaw()->Double? {
        return SSMemoryInfo.purgableMemory(inPercent: false)
    }
    
    func purgableMemoryinPercent()->Double? {
        return SSMemoryInfo.purgableMemory(inPercent: true)
    }
    
    
    func deviceOrientation()->UIInterfaceOrientation {
        return SSAccelerometerInfo.deviceOrientation()
    }
    
    
    
    func country()->String {
        return SSLocalizationInfo.country()
    }
    
    func language()->String? {
        return SSLocalizationInfo.language()
    }
    
    func timeZoneSS()->String {
        return SSLocalizationInfo.timeZone()
    }
    
    func currency()->String? {
        return SSLocalizationInfo.currency()
    }
    
    
    
    func applicationVersion()->String? {
        return SSApplicationInfo.applicationVersion()
    }
    
    func clipboardContent()->String? {
        return SSApplicationInfo.clipboardContent()
    }
    
    func applicationCPUUsage()->Double {
        return SSApplicationInfo.cpuUsage()
    }
    
    
    func cfuuid()->String {
        return SSUUID.uuid()
    }
    
    
    
    
    func allSystemInformation()->[(String, String)] {
        return getAllSystemInformation()
    }
    
    
    private func getAllSystemInformation()->[(String, String)]{
        var infos = [(String, String)]()
        
        infos.append(("System Uptime", systemUptime()))
        infos.append(("Device Model", deviceModel()))
        infos.append(("Device Name", deviceName()))
        infos.append(("System Name", systemName()))
        infos.append(("Systems Version", systemsVersion()))
        infos.append(("System Device Type Not-Formatted", systemDeviceTypeNotFormatted()))
        infos.append(("System Device Type Formatted", systemDeviceTypeFormatted()))
        infos.append(("Screen Width", screenWidth().description))
        infos.append(("Screen Height", screenHeight().description))
        infos.append(("Screen Brightness", screenBrightness().description))

        infos.append(("Multitasking Enabled", multitaskingEnabled().description))
        infos.append(("Proximity Sensor Enabled", proximitySensorEnabled().description))
        infos.append(("Plugged-In", pluggedIn().description))
        infos.append(("Step Counting Available", stepCountingAvailable().description))
        infos.append(("Distance Available", distanceAvailable().description))
        infos.append(("Floor Counting Available", floorCountingAvailable().description))
        infos.append(("jailbroken", jailbroken().description))
        infos.append(("Number of Processors", numberProcessors().description))
        infos.append(("Number of Active Processors", numberActiveProcessors().description))
        infos.append(("Processors Usage", processorsUsage().description))
        infos.append(("Headphones Attached", headphonesAttached().description))
        infos.append(("Number of Attached Accessories", numberAttachedAccessories().description))
        infos.append(("Name of Attached Accessories", nameAttachedAccessories() ?? "Unknown"))
        infos.append(("CarrierName", carrierName() ?? "Unknown"))
        infos.append(("Carrier Country", carrierCountry() ?? "Unknown"))
        infos.append(("Carrier Mobile Country Code", carrierMobileCountryCode() ?? "Unknown"))
        infos.append(("Carrier ISO Country Code", carrierISOCountryCode() ?? "Unknown"))
        infos.append(("Carrier Mobile NetworkCode", carrierMobileNetworkCode() ?? "Unknown"))
        infos.append(("Carrier Allows VOIP", carrierAllowsVOIP().description))
        infos.append(("battery Level", batteryLevel().description))
        infos.append(("Charging", charging().description))
        infos.append(("Fully Charged", fullyCharged().description))
        infos.append(("Current IP Address", currentIPAddress() ?? "Unknown"))
        infos.append(("External IP Address", externalIPAddress() ?? "Unknown"))
        infos.append(("Cell IP Address", cellIPAddress() ?? "Unknown"))
        
        infos.append(("Cell Broadcast Address", cellBroadcastAddress() ?? "Unknown"))
        infos.append(("WiFi IP Address", wiFiIPAddress() ?? "Unknown"))
        infos.append(("WiFi Broadcast Address", wiFiBroadcastAddress() ?? "Unknown"))
        infos.append(("Connected To WiFi", connectedToWiFi().description))
        infos.append(("Connected To CellNetwork", connectedToCellNetwork().description))
        infos.append(("Process ID", processID().description))
        infos.append(("Disk Space", diskSpace() ?? "Unknown"))
        infos.append(("Free Disk Space inRaw", freeDiskSpaceinRaw() ?? "Unknown"))
        infos.append(("Free Disk Space inPercent", freeDiskSpaceinPercent() ?? "Unknown"))
        infos.append(("Used Disk Space inRaw", usedDiskSpaceinRaw() ?? "Unknown"))
        infos.append(("Used Disk Space inPercent", usedDiskSpaceinPercent() ?? "Unknown"))
      
        infos.append(("Long Disk Space", longDiskSpace()?.description ?? "Unknown"))
        infos.append(("Long Free Disk Space", longFreeDiskSpace()?.description ?? "Unknown"))
        infos.append(("total Memory", totalMemory()?.description ?? "Unknown"))
        infos.append(("Free Memory inRaw", freeMemoryinRaw()?.description ?? "Unknown"))
        infos.append(("Free Memory inPercent", freeMemoryinPercent()?.description ?? "Unknown"))
        infos.append(("Used Memory inRaw", usedMemoryinRaw()?.description ?? "Unknown"))
        infos.append(("Used Memory inPercent", usedMemoryinPercent()?.description ?? "Unknown"))
        infos.append(("Active Memory inRaw", activeMemoryinRaw()?.description ?? "Unknown"))
        infos.append(("Active Memory inPercent", activeMemoryinPercent()?.description ?? "Unknown"))
        infos.append(("inactive Memory inRaw", inactiveMemoryinRaw()?.description ?? "Unknown"))
        infos.append(("inactive Memory inPercent", inactiveMemoryinPercent()?.description ?? "Unknown"))
        infos.append(("Wired Memory inRaw", wiredMemoryinRaw()?.description ?? "Unknown"))
        infos.append(("Wired Memory inPercent", wiredMemoryinPercent()?.description ?? "Unknown"))
        infos.append(("Purgable Memory inRaw", purgableMemoryinRaw()?.description ?? "Unknown"))
        infos.append(("Purgable Memory inPercent", purgableMemoryinPercent()?.description ?? "Unknown"))
        infos.append(("Device Orientation", deviceOrientation().rawValue.description))
        
        return infos
    }
    
}
