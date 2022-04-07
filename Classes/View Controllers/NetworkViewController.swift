//
//  ViewController.swift
//  DevicesystemDataArraywift
//
//  Created by Zaber on 2/4/22.
//

import UIKit

class NetworkViewController: UIViewController {
    
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
    
    
    private func refreshData(){
        systemDataArray.removeAll()
        infoTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.getAllNetworkSystemDataArray()
            self.infoTableView.reloadData()
        }
    }
    
    private func getAllNetworkSystemDataArray(){
        systemDataArray.append(("CarrierName :",  SystemService.shared.carrierName() ?? "Unknown"))
        systemDataArray.append(("Carrier Country :",  SystemService.shared.carrierCountry() ?? "Unknown"))
        systemDataArray.append(("Carrier Mobile Country Code :",  SystemService.shared.carrierMobileCountryCode() ?? "Unknown"))
        systemDataArray.append(("Carrier ISO Country Code :",  SystemService.shared.carrierISOCountryCode() ?? "Unknown"))
        systemDataArray.append(("Carrier Mobile Network Code :",  SystemService.shared.carrierMobileNetworkCode() ?? "Unknown"))
        systemDataArray.append(("Carrier Allows VOIP :",  SystemService.shared.carrierAllowsVOIP().description))
        
        systemDataArray.append(("Current IP Address :",  SystemService.shared.currentIPAddress() ?? "Unknown"))
        systemDataArray.append(("External IP Address :",  SystemService.shared.externalIPAddress() ?? "Unknown"))
        systemDataArray.append(("Cell IP Address :",  SystemService.shared.cellIPAddress() ?? "Unknown"))
        
        systemDataArray.append(("Cell Broadcast Address :",  SystemService.shared.cellBroadcastAddress() ?? "Unknown"))
        systemDataArray.append(("WiFi IP Address :",  SystemService.shared.wiFiIPAddress() ?? "Unknown"))
        systemDataArray.append(("WiFi Broadcast Address :",  SystemService.shared.wiFiBroadcastAddress() ?? "Unknown"))
        systemDataArray.append(("Connected To WiFi :",  SystemService.shared.connectedToWiFi().description))
        systemDataArray.append(("Connected To CellNetwork :",  SystemService.shared.connectedToCellNetwork().description))
    }
    
    @IBAction func refreshAction(){
        refreshData()
    }
}



extension NetworkViewController: UITableViewDelegate, UITableViewDataSource {
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


