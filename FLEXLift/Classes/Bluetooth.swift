//
//  Bluetooth.swift
//  FLEX Lift
//
//  Created by Ava Luna Pardo Keegan on 11/6/23.
//

import Foundation
import CoreBluetooth

extension Date {
    func currentTimeSec() -> Double {
        return Double(self.timeIntervalSince1970)
    }
}

var timer: Timer?

let SAMPLE_RATE = 25
let PROMINENCE = 0.6
var LAG_WIDTH = 5 * SAMPLE_RATE

let backgroundQueue = DispatchQueue(label: "com.example.myapp.backgroundqueue")

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    // Published properties that the SwiftUI Views can bind to
    @Published var isScanning: Bool = false
    @Published var isConnected: Bool = false
    @Published var foundPeripherals: [CBPeripheral] = []
    @Published var REP_COUNT: Int = -1
    private var FUNCTIONAL_SENSOR = true
    @Published var entries: [ENTRY] = []
    private var REP_WIDTH = -1
    private var START_IDX = -1
    private var IN_SESSION = false
    private var FIRST = true
    private var NO_MOVEMENT_DETECTED = false
    @Published var repStartLocs: [Int] = []
    
    // Core Bluetooth properties
    private var centralManager: CBCentralManager?
    private var myPeripheral: CBPeripheral?
    private var myCharacteristic: CBCharacteristic?
    
    // Define your service and characteristic UUIDs
    let serviceUUID = CBUUID(string: "ab0828b1-198e-4351-b779-901fa0e03710")
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            self?.calculateRepCount()
        }
    }
    
    // MARK: - Custom Methods
    
    func resetBluetooth(){
        self.REP_COUNT = -1
        self.FUNCTIONAL_SENSOR = true
        self.entries = []
        self.REP_WIDTH = -1
        self.START_IDX = -1
        self.IN_SESSION = false
        self.FIRST = true
        self.NO_MOVEMENT_DETECTED = false
        self.repStartLocs = []
    }
    
    func calculateRepCount() {
        backgroundQueue.async {
            if self.entries.count < LAG_WIDTH {
                if self.entries.count > 2 * SAMPLE_RATE {
                    let allZeros = self.entries.allSatisfy { $0.value == 0.0 }
                    if allZeros {
                        print("Error! Restart FLEX Lift Collar")
                        self.entries.removeAll()
                        self.FUNCTIONAL_SENSOR = false
                    }
                    else{
                        self.FUNCTIONAL_SENSOR = true
                    }
                }
            }
            else if (self.FIRST) {
                (self.REP_COUNT, self.REP_WIDTH, self.START_IDX, self.NO_MOVEMENT_DETECTED) = self.getRepCountSetup(entries: self.entries, lagWidth: LAG_WIDTH)
                if self.NO_MOVEMENT_DETECTED {
                    print("No movement detected! Resetting...")
                    self.entries.removeAll()
                }
                else {
                    self.FIRST = false
                }
            }
            else {
                if self.entries.count >= self.START_IDX + self.REP_WIDTH {
                        self.REP_COUNT = max(self.REP_COUNT, self.getRepCount(entries: self.entries, startIdx: self.START_IDX, repWidth: self.REP_WIDTH))
                }
            }
            
            DispatchQueue.main.async {
                if self.REP_COUNT == -1 {
                    print("Analyzing...")
                }
                else {
                    print("Repcount: \(self.REP_COUNT)")
                }
            }
        }
    }
    
    func connect() {
        guard centralManager?.state == .poweredOn else {
            print("Bluetooth is not turned on.")
            return
        }
        centralManager?.stopScan()
        
        isScanning = true
        print("Scanning")
        centralManager?.scanForPeripherals(withServices: [serviceUUID], options: nil)
    }
    
    func disconnect() {
        if let peripheral = myPeripheral {
            centralManager?.cancelPeripheralConnection(peripheral)
        }
    }
    
    func sendText(_ text: String) {
        guard let peripheral = myPeripheral,
              let characteristic = myCharacteristic,
              let data = text.data(using: .utf8) else {
            print("Peripheral or characteristic not found, or text could not be encoded.")
            return
        }
        
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
    
    func connectToPeripheral(_ peripheral: CBPeripheral) {
        centralManager?.connect(peripheral, options: nil)
    }
    
    // MARK: - CBCentralManagerDelegate Methods
    
    //check
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is switched on")
            // Start scanning or do other stuff
        case .poweredOff:
            print("Bluetooth is switched off")
            // Handle as needed
        case .unsupported:
            print("Bluetooth is not supported")
            // Handle as needed
        default:
            print("Unknown state")
        }
    }
    
    //check
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(advertisementData)
        print("Discovered peripheral: \(peripheral.name ?? "Unknown")")
        
        centralManager?.stopScan()
        centralManager?.connect(peripheral, options: nil)
        
        myPeripheral = peripheral
        myPeripheral?.delegate = self
        print("connectecd to myPeripheral")
    }
    
    //check
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([serviceUUID])
        isConnected = true
        
        print("Successfully connected to the device!")
    }
    
    //check
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral == myPeripheral {
            isConnected = false
            myPeripheral = nil
            myCharacteristic = nil
            print("Disconnected from " +  peripheral.name!)
        }
    }
    
    //check
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error!)
        print("Failed to connect.")
    }
    
    // MARK: - CBPeripheralDelegate Methods
    
    //check
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        guard let services = peripheral.services else { return }
        
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    //check
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("didDiscoverCharacteristicsFor")
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            if characteristic.properties.contains(.write) {
                myCharacteristic = characteristic
            }
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            return
        }
        // Get notification from ESP32
        guard let data = characteristic.value else { return }
        let floatValue = data.withUnsafeBytes { $0.load(as: Float.self) }
        let timestamp = Date().currentTimeSec()
        let newEntry = ENTRY(timestamp: timestamp, value: Double(floatValue))
        entries.append(newEntry)
    }
    
    func rootMeanSquared(_ array: [Double]) -> Double {
        guard !array.isEmpty else {
            return 0
        }
        let sumOfSquares = array.reduce(0) { $0 + ($1 * $1) }
        let meanOfSquares = sumOfSquares / Double(array.count)
        return sqrt(meanOfSquares)
    }
    
    func norm(_ array: [Double]) -> Double {
        return sqrt(array.map { $0 * $0 }.reduce(0, +))
    }
    
    func dotProduct(_ a: [Double], _ b: [Double]) -> Double {
        return zip(a, b).map { $0 * $1 }.reduce(0, +)
    }
    
    func autocorrelate(y: [Double], wlen: Int) -> [Double] {
        if y.count < wlen {
            print("warning! size of y is smaller than wlen")
            return []
        }
        else {
            let n = y.count - wlen + 1
            var ac = [Double](repeating: 0.0, count: n)
            let hw = Array(y[0..<wlen])
            let hw_norm = norm(hw)
            
            for i in 0..<n {
                let w = Array(y[i..<(i+wlen)])
                let w_norm = norm(w)
                ac[i] = dotProduct(hw, w) / (hw_norm * w_norm)
            }
            return ac
        }
    }
    
    func mean(_ numbers: [Double]) -> Double {
        guard !numbers.isEmpty else {
            return 0.0
        }
        let sum = numbers.reduce(0, +)
        return sum / Double(numbers.count)
    }
    
    func findPeaks(in data: [Double], minPeakHeight: Double, minPeakDistance: Int) -> [(vals: Double, locs: Int)] {
        var peaks = [(vals: Double, locs: Int)]()
        if data.count <= 1 {
            return peaks
        }
        for i in 1..<(data.count - 1) {
            if data[i] > data[i - 1] && data[i] > data[i + 1] && data[i] > minPeakHeight {
                peaks.append((vals: data[i], locs: i))
            }
        }
        var filteredPeaks = [(vals: Double, locs: Int)]()
        for currentPeak in peaks {
            var isPeakValid = true
            var index = 0
            while index < filteredPeaks.count {
                let existingPeak = filteredPeaks[index]
                let distance = abs(currentPeak.locs - existingPeak.locs)
                if distance < minPeakDistance {
                    if currentPeak.vals < existingPeak.vals {
                        isPeakValid = false
                        break
                    } else {
                        filteredPeaks.remove(at: index)
                    }
                } else {
                    index += 1
                }
            }
            if isPeakValid {
                filteredPeaks.append(currentPeak)
            }
        }
        return filteredPeaks
    }
    
    func getRepCountSetup(entries: [ENTRY], lagWidth: Int) -> (repCount: Int, repWidth: Int, startIdx: Int, noMovementDetected: Bool) {
        var repCount = 0
        var repWidth = 0
        var startIdx = 0
        
        // peak detection
        let sensorData = Array(entries.map { $0.value })
        let minPeakVal = rootMeanSquared(sensorData)*1.25
        let peaks = findPeaks(in: sensorData, minPeakHeight: minPeakVal, minPeakDistance: SAMPLE_RATE)
        
        var lminima = [Double](repeating: 0.0, count: sensorData.count)
        lminima[0] = sensorData[0]
        for i in 1..<sensorData.count {
            if sensorData[i] >= sensorData[i - 1] {
                lminima[i] = lminima[i - 1]
            } else {
                lminima[i] = sensorData[i]
            }
        }
        
        var rminima = [Double](repeating: 0.0, count: sensorData.count)
        rminima[sensorData.count - 1] = sensorData[sensorData.count - 1]
        for i in stride(from: sensorData.count - 2, through: 0, by: -1) {
            if sensorData[i] >= sensorData[i + 1] {
                rminima[i] = rminima[i + 1]
            } else {
                rminima[i] = sensorData[i]
            }
        }
        
        var locs = peaks.map { $0.locs }
        var vals = peaks.map { $0.vals }
        
        let rminimaSel = locs.map { rminima[$0] }
        let lminimaSel = locs.map { lminima[$0] }
        let largeProminenceIdx = vals.enumerated().filter { $0.element - min(rminimaSel[$0.offset], lminimaSel[$0.offset]) > PROMINENCE }.map { $0.offset }
        
        vals = largeProminenceIdx.map { vals[$0] }
        locs = largeProminenceIdx.map { locs[$0] }
        repCount = locs.count
        
        if repCount == 0 {
            return (-1, -1, -1, true)
        }
        else if repCount == 1 {
            repWidth = max(SAMPLE_RATE * 2, Int(ceil(Double(lagWidth/2))))
            startIdx = max(0, (locs[0] - repWidth/2))
            repStartLocs = [startIdx]
        }
        else {
            if repCount > 3 {
                print("3+ peaks detected in the first 5 seconds, adjusting to 3 peaks")
                let sortedArray = Array(vals.enumerated()).sorted { $0.element > $1.element }
                let topIndices = Array(sortedArray.prefix(3)).map { $0.offset }
                vals = topIndices.map { vals[$0] }
                locs = topIndices.map { locs[$0] }
                repCount = 3
            }
            
            // find the average distance between each consecutive peaks
            var locsDifferences: [Int] = Array(repeating: 0, count: repCount - 1)
            for i in 1..<repCount {
                locsDifferences[i - 1] = locs[i] - locs[i - 1]
            }
            
            // subtract half the repWidth from the first peak
            let averageDistance = Double(locsDifferences.reduce(0, +)) / Double(locsDifferences.count)
            repWidth = max(SAMPLE_RATE * 2, Int(ceil(averageDistance)))
            startIdx = max(0, (locs[0] - repWidth/2))
            repStartLocs = locs.map { max($0 - repWidth/2, 0) }
        }
        
        print("repCount = \(repCount), repWidth = \(repWidth), startIdx = \(startIdx)")
        return (repCount, repWidth, startIdx, false)
    }
    
    // --------------------------------------------------------------------------------------------------------------------------------------- modified getRepCount function
    
    // call periodically after entries.count exceeds a certain threshold
    func getRepCount(entries: [ENTRY], startIdx: Int, repWidth: Int) -> Int {
        
        // Find peaks of ac
        let sensorData = Array(entries[startIdx...].map { $0.value })
        let acSensorData = autocorrelate(y: sensorData, wlen: repWidth)
        let acMinPeakVal = rootMeanSquared(acSensorData)*1.25
        let peaks = findPeaks(in: acSensorData, minPeakHeight: acMinPeakVal, minPeakDistance: SAMPLE_RATE)
        
        if peaks.isEmpty {
            print("uh oh. you should not see this message")
            return 0
        }
        
        // Evaluate peaks
        var lminima = [Double](repeating: 0.0, count: acSensorData.count)
        lminima[0] = acSensorData[0]
        for i in 1..<acSensorData.count {
            if acSensorData[i] >= acSensorData[i - 1] {
                lminima[i] = lminima[i - 1]
            } else {
                lminima[i] = acSensorData[i]
            }
        }
        
        var rminima = [Double](repeating: 0.0, count: acSensorData.count)
        rminima[acSensorData.count - 1] = acSensorData[acSensorData.count - 1]
        for i in stride(from: acSensorData.count - 2, through: 0, by: -1) {
            if acSensorData[i] >= acSensorData[i + 1] {
                rminima[i] = rminima[i + 1]
            } else {
                rminima[i] = acSensorData[i]
            }
        }
        
        let locs = peaks.map { $0.locs }
        let vals = peaks.map { $0.vals }
        
        let rminimaSel = locs.map { rminima[$0] }
        let lminimaSel = locs.map { lminima[$0] }
        let largeProminenceIdx = vals.enumerated().filter { $0.element - min(rminimaSel[$0.offset], lminimaSel[$0.offset]) > PROMINENCE }.map { $0.offset }
        
        // Keep the good peaks
        repStartLocs = largeProminenceIdx.map { locs[$0] }
        for i in 0..<repStartLocs.count {
            repStartLocs[i] += startIdx
        }
        repStartLocs = [startIdx] + repStartLocs
        return repStartLocs.count
    }
    
}
