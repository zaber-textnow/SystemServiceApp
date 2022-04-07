//
//  ViewController.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 2/4/22.
//

import UIKit
import SystemService

class DiskViewController: UIViewController {
    
    @IBOutlet private var totalDiskLabel: UILabel!
    @IBOutlet private var usedDiskLabel: UILabel!
    @IBOutlet private var freeDiskLabel: UILabel!
    @IBOutlet private var gaugeHolderView: UIView!
    
    private var annotatedGauge: MSAnnotatedGauge!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
    }
    
    @IBAction func refreshAction(){
        refreshData()
    }
    
    private func refreshData(){
        
        totalDiskLabel.text = String(format: "Total Disk Space: %@", SystemService.shared.diskSpace() ?? "")
        usedDiskLabel.text = String(format: "Used Disk Space: %@ %@", SystemService.shared.usedDiskSpaceinRaw() ?? "", SystemService.shared.usedDiskSpaceinPercent() ?? "")
        freeDiskLabel.text = String(format: "Free Disk Space: %@ %@", SystemService.shared.freeDiskSpaceinRaw() ?? "", SystemService.shared.freeDiskSpaceinPercent() ?? "")
        
        if annotatedGauge == nil {
            annotatedGauge = MSAnnotatedGauge.init(frame: gaugeHolderView.bounds)
            annotatedGauge.minValue = 0
            annotatedGauge.maxValue = 100
            annotatedGauge.backgroundColor = .clear
            
            gaugeHolderView.addSubview(annotatedGauge)
            gaugeHolderView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(
                [annotatedGauge.leadingAnchor.constraint(equalTo: gaugeHolderView.leadingAnchor),
                 annotatedGauge.trailingAnchor.constraint(equalTo: gaugeHolderView.trailingAnchor),
                 annotatedGauge.topAnchor.constraint(equalTo: gaugeHolderView.topAnchor, constant: 40),
                 annotatedGauge.bottomAnchor.constraint(equalTo: gaugeHolderView.bottomAnchor)]
            )
        }
        
        annotatedGauge.titleLabel.text = String(format: "Total Space: %@", SystemService.shared.diskSpace() ?? "")
        annotatedGauge.startRangeLabel.text = String(format: "%@ Used", SystemService.shared.usedDiskSpaceinRaw() ?? "")
        annotatedGauge.endRangeLabel.text = String(format: "%@ Free", SystemService.shared.freeDiskSpaceinRaw() ?? "")
        
        
        var value = SystemService.shared.usedDiskSpaceinPercent() ?? ""
        value = value.replacingOccurrences(of: " %", with: "")
        
        annotatedGauge.value = Float(value) ?? 0.0
    }
    
}


