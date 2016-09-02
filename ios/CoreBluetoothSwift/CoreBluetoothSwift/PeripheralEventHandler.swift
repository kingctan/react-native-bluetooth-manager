//
//  PeripheralEventHandler.swift
//  ReactNativeBluetooth
//

import Foundation
import CoreBluetooth

class PeripheralEventHandler: NSObject, CBPeripheralDelegate {
    private var onServiceDiscovered: ServiceDiscoveryCallback?
    private var onCharacteristicDiscovered: ServiceCallback?
    private var onCharacteristicValueUpdated: CharacteristicCallback?
    private var onCharacteristicValueWritten: CharacteristicCallback?
    private var onCharacteristicNotify: CharacteristicCallback?

    override init() {
        super.init()
    }

    func onServiceDiscovered(handler: ServiceDiscoveryCallback) {
        self.onServiceDiscovered = handler
    }

    func onCharacteristicDiscovered(handler: ServiceCallback) {
        self.onCharacteristicDiscovered = handler
    }

    func onCharacteristicValueUpdated(handler: CharacteristicCallback) {
        self.onCharacteristicValueUpdated = handler
    }

    func onCharacteristicValueWritten(handler: CharacteristicCallback) {
        self.onCharacteristicValueWritten = handler
    }

    func onCharacteristicNotify (handler: CharacteristicCallback) {
        self.onCharacteristicNotify = handler
    }

    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        guard let handler = self.onServiceDiscovered else {
            print("Peripheral discovered but no handler set", peripheral.name)
            return
        }

        handler(peripheral, error: error)
    }

    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService,
                    error: NSError?) {
        guard let handler = self.onCharacteristicDiscovered else {
            print("Characteristic discovered but no handler set", peripheral.name)
            return
        }

        handler(peripheral, service, error)
    }

    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic,
                  error: NSError?) {
        guard let handler = self.onCharacteristicValueUpdated else {
            print("Characteristic updated but no handler set", peripheral.name)
            return
        }

        handler(peripheral, characteristic, error)
    }

    func peripheral(peripheral: CBPeripheral,
                  didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard let handler = self.onCharacteristicValueWritten else {
            print("Characteristic written but no handler set", peripheral.name)
            return
        }

        handler(peripheral, characteristic, error)
    }

    func peripheral(peripheral: CBPeripheral,
                  didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard let handler = self.onCharacteristicNotify else {
            print("Characteristic written but no handler set", peripheral.name)
            return
        }

        handler(peripheral, characteristic, error)
    }
}
