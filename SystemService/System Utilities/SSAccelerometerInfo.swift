//
//  SSAccelerometerInfo.swift
//  DeviceInfoSwift
//
//  Created by Zaber on 3/4/22.
//

import UIKit
import Foundation
import CoreMotion

class SSAccelerometerInfo: NSObject {
    
    private var motionManager: CMMotionManager!
    private var deviceMotionQueue: OperationQueue!
    private var accelQueue: OperationQueue!
    private var gyroQueue: OperationQueue!

    
    private(set) var attitudeString: String?
    private(set) var gravityString: String?
    private(set) var magneticFieldString: String?
    private(set) var rotationRateString: String?
    private(set) var userAccelerationString: String?
    private(set) var rawGyroscopeString: String?
    private(set) var rawAccelerometerString: String?


    static func deviceOrientation()->UIInterfaceOrientation {
      return UIApplication.shared.statusBarOrientation
    }
    
    func startLoggingMotionData() {
        motionManager = CMMotionManager.init()
        motionManager.deviceMotionUpdateInterval = 0.01
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.gyroUpdateInterval = 0.01
        
        deviceMotionQueue = OperationQueue.init()
        deviceMotionQueue.maxConcurrentOperationCount = 1
        
        accelQueue = OperationQueue.init()
        accelQueue.maxConcurrentOperationCount = 1
        
        gyroQueue = OperationQueue.init()
        gyroQueue.maxConcurrentOperationCount = 1
        
        
        motionManager.startDeviceMotionUpdates(to: deviceMotionQueue) { motion, error in
            self.processMotion(motion, error: error)
        }
        
        motionManager.startGyroUpdates(to: gyroQueue) { gryo, error in
            self.processGyro(gryo, error: error)
        }
        
        
        motionManager.startAccelerometerUpdates(to: accelQueue) { accel, error in
            self.processAccel(accel, error: error)
        }
    }
    
    private func processAccel(_ accelData: CMAccelerometerData?, error: Error?){
        if let accelData = accelData, error == nil {
            rawAccelerometerString =  String(format: "%f,%f,%f,%f\n", accelData.timestamp,
                                             accelData.acceleration.x,
                                             accelData.acceleration.y,
                                             accelData.acceleration.z)
        }
        else {
            rawAccelerometerString = ""
        }
    }
    
    private func processGyro(_ gyroData: CMGyroData?, error: Error?){
        if let gyroData = gyroData, error == nil {
            rawGyroscopeString =  String(format: "%f,%f,%f,%f\n", gyroData.timestamp,
                                             gyroData.rotationRate.x,
                                             gyroData.rotationRate.y,
                                             gyroData.rotationRate.z)
        }
        else {
            rawGyroscopeString = ""
        }
    }
    
    private func processMotion(_ motion: CMDeviceMotion?, error: Error?){
        if let motion = motion, error == nil {
            attitudeString =  String(format: "%f,%f,%f,%f\n", motion.timestamp,
                                     motion.attitude.roll,
                                     motion.attitude.pitch,
                                     motion.attitude.yaw)
            
            gravityString =  String(format: "%f,%f,%f,%f\n", motion.timestamp,
                                    motion.gravity.x,
                                    motion.gravity.y,
                                    motion.gravity.z)
            
            magneticFieldString =  String(format: "%f,%f,%f,%f,%d\n", motion.timestamp,
                                          motion.magneticField.field.x,
                                          motion.magneticField.field.y,
                                          motion.magneticField.field.z,
                                          motion.magneticField.accuracy.rawValue)
            
            rotationRateString =  String(format: "%f,%f,%f,%f\n", motion.timestamp,
                                         motion.rotationRate.x,
                                         motion.rotationRate.y,
                                         motion.rotationRate.z)
            
            userAccelerationString =  String(format: "%f,%f,%f,%f\n", motion.timestamp,
                                             motion.userAcceleration.x,
                                             motion.userAcceleration.y,
                                             motion.userAcceleration.z)
            
    
        }
        else {
            attitudeString = ""
            gravityString = ""
            magneticFieldString = ""
            rotationRateString = ""
            userAccelerationString = ""
        }
    }
    
   
    
    
    func stopLoggingMotionData() {
        motionManager?.stopDeviceMotionUpdates()
        deviceMotionQueue.waitUntilAllOperationsAreFinished()
        
        motionManager.stopAccelerometerUpdates()
        accelQueue.waitUntilAllOperationsAreFinished()
        
        motionManager.stopGyroUpdates()
        gyroQueue.waitUntilAllOperationsAreFinished()
    }
    
}
