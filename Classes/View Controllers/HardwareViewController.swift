//
//  ViewController.swift
//  DevicesystemDataArraywift
//
//  Created by Zaber on 2/4/22.
//

import UIKit

class HardwareViewController: UIViewController {
    
    @IBOutlet weak var infoTableView: UITableView!
    
    private var systemDataArray = [(String, String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshData()
    }
    
    private func setupUI(){
        infoTableView.register(SytemInfoTableCell.nib(), forCellReuseIdentifier: SytemInfoTableCell.identifier())
    }
    
    @IBAction func refreshAction(){
        refreshData()
    }
    
    func refreshData(){
        systemDataArray.removeAll()
        infoTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.getAllHarwaresystemDataArray()
            self.infoTableView.reloadData()
        }
    }
    
    func getAllHarwaresystemDataArray(){
        systemDataArray.append(("System Uptime", SystemService.shared.systemUptime()))
        systemDataArray.append(("Device Model", SystemService.shared.deviceModel()))
        systemDataArray.append(("Device Name", SystemService.shared.deviceName()))
        systemDataArray.append(("System Name", SystemService.shared.systemName()))
        systemDataArray.append(("Systems Version", SystemService.shared.systemsVersion()))
        systemDataArray.append(("System Device Type Not-Formatted", SystemService.shared.systemDeviceTypeNotFormatted()))
        systemDataArray.append(("System Device Type Formatted", SystemService.shared.systemDeviceTypeFormatted()))
        systemDataArray.append(("Screen Width", SystemService.shared.screenWidth().description))
        systemDataArray.append(("Screen Height", SystemService.shared.screenHeight().description))
        systemDataArray.append(("Screen Brightness", SystemService.shared.screenBrightness().description))
        
        systemDataArray.append(("Multitasking Enabled", SystemService.shared.multitaskingEnabled().description))
        systemDataArray.append(("Proximity Sensor Enabled", SystemService.shared.proximitySensorEnabled().description))
        systemDataArray.append(("Plugged-In", SystemService.shared.pluggedIn().description))
        systemDataArray.append(("Step Counting Available", SystemService.shared.stepCountingAvailable().description))
        systemDataArray.append(("Distance Available", SystemService.shared.distanceAvailable().description))
        systemDataArray.append(("Floor Counting Available", SystemService.shared.floorCountingAvailable().description))
        systemDataArray.append(("jailbroken", SystemService.shared.jailbroken().description))
        systemDataArray.append(("Number of Processors", SystemService.shared.numberProcessors().description))
        systemDataArray.append(("Number of Active Processors", SystemService.shared.numberActiveProcessors().description))
        systemDataArray.append(("Processors Usage", SystemService.shared.processorsUsage().description))
        systemDataArray.append(("Headphones Attached", SystemService.shared.headphonesAttached().description))
        systemDataArray.append(("Number of Attached Accessories", SystemService.shared.numberAttachedAccessories().description))
        systemDataArray.append(("Name of Attached Accessories", SystemService.shared.nameAttachedAccessories() ?? "Unknown"))
        systemDataArray.append(("Device Orientation", SystemService.shared.deviceOrientation().rawValue.description))
        
        systemDataArray.append(("Carrier Country", SystemService.shared.country()))
        systemDataArray.append(("Language", SystemService.shared.language() ?? "Unknown"))
        systemDataArray.append(("timeZone", SystemService.shared.timeZoneSS()))
        systemDataArray.append(("applicationVersion", SystemService.shared.applicationVersion() ?? "Unknown"))
        systemDataArray.append(("clipboardContent", SystemService.shared.clipboardContent()?.description ?? ""))
        systemDataArray.append(("CFUUID", SystemService.shared.cfuuid().description))
    }
}



extension HardwareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systemDataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SytemInfoTableCell.identifier()) as! SytemInfoTableCell
        cell.reload(info: systemDataArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}


