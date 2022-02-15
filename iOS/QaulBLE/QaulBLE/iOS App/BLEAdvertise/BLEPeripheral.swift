//
//  BLEPeripheral.swift
//  QaulBLE
//
//  Created by BAPS on 27/01/22.
//


import Foundation
import CoreBluetooth

public let kTRANSFER_SERVICE_UUID        = "33c0ac57-d316-43ec-a883-691fc200e37b".uppercased()
public let kTRANSFER_CHARACTERISTIC_UUID = "aec5e807-83e9-4fce-a5a9-3790cd63a977".uppercased()

let bLEPeripheral = BLEPeripheral()

public class BLEPeripheral: NSObject, CBPeripheralManagerDelegate, CBPeripheralDelegate {
    
    static let shared = BLEPeripheral()
        
    //((status: Bool, errorText: String, unknownError: Bool) -> Void)
    public typealias startAdvertiseRes = ((Bool,  String, Bool) -> Void)
    private var StartbleAdvertiseCallback: startAdvertiseRes!
    
    //((status: Bool, errorText: String) -> Void)
    public typealias stopAdvertiseRes = ((Bool,  String) -> Void)
    private var StopbleAdvertiseCallback: stopAdvertiseRes!
    
    var peripheralManager: CBPeripheralManager
    private let beaconOperationsQueue = DispatchQueue(label: "beacon_operations_queue")
    private var peripheralName: String?
    private var connectTarget: CBPeripheral?
    
    private var servicesIDs = CBUUID()
    
    var isStartAdvertising = false
    
    override init() {
        
        self.peripheralManager = CBPeripheralManager(delegate: nil, queue: beaconOperationsQueue, options: nil)
        super.init()

        self.peripheralManager.delegate = self
    }
    
    public func startAdvertising(serviceID: String, name: String, bleCallback: @escaping startAdvertiseRes) {
        
        StartbleAdvertiseCallback = bleCallback
        
        let valueData = name.data(using: .utf8)
        
        self.peripheralName = name
        
        servicesIDs = CBUUID(string: serviceID)
        
        let CustomChar = CBMutableCharacteristic(type: CBUUID(string: kTRANSFER_CHARACTERISTIC_UUID), properties: [.read], value: valueData, permissions: [.readable])
        
        let myService = CBMutableService(type: servicesIDs, primary: true)
        myService.characteristics = [CustomChar]
        
        peripheralManager.removeAllServices()
        peripheralManager.add(myService)
        self.perform(#selector(self.startAdvertise), with: nil, afterDelay: 1.0)
        
    }
    @objc fileprivate func startAdvertise() {
        peripheralManager.startAdvertising([
            CBAdvertisementDataServiceUUIDsKey: [servicesIDs],
            CBAdvertisementDataLocalNameKey: self.peripheralName!])
    }
    
    public func stopAdvertising(bleCallback: @escaping stopAdvertiseRes) {
        StopbleAdvertiseCallback = bleCallback
        self.peripheralManager.stopAdvertising()
        StopbleAdvertiseCallback(true , "")
    }
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if peripheral.state == .poweredOn {
            
            let dict = ["isBluetoothOn": true, "comeFrom": true] as [String : Any]
            NotificationCenter.default.post(name: Notification.Name("bleState"), object: dict)
            print("Powered on, start advertising")
            
        } else {
            
            self.peripheralManager.stopAdvertising()
            let dict = ["isBluetoothOn": true, "comeFrom": true] as [String : Any]
            NotificationCenter.default.post(name: Notification.Name("bleState"), object: dict)
        }
    }
    public func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        
        if error == nil{
            self.isStartAdvertising =  true
            print("Start Advertising.....")
            StartbleAdvertiseCallback(true , "" , false)
        }else{
            self.isStartAdvertising =  false
            let errstring = error?.localizedDescription ?? "Un knownError"
            StartbleAdvertiseCallback(false , errstring , errstring == "Un knownError" ? true : false)
        }
        
        //locManager.appendNewText(text: "Start Advertising.....")
    }
}