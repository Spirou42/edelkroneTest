/**
  edelkroneModels.swift
  edelkroneTest
	
 Containing basic models for api results
 
  Created by Carsten Müller on 07.03.2022.
 */

import Foundation
import SwiftUI

// MARK: - LinkAdapter
class LinkAdapter: Identifiable, Decodable, ObservableObject, Hashable{
  /// some informations about the firmware status if this link adapter
  enum connectionTypes : String, Decodable{
    case none, canbus, wireless
  }
  let updateAvailable 	: Bool
  let updateRequired 		: Bool
  let firmwareCorrupted : Bool?
  
  let radioUpdateAvailable: Bool
  let radioUpdateRequired : Bool
  
  /// a collection of connection types the linkAdapter uses
  let connactionType : connectionTypes
  
  /// the epoc the adapter was found. This String is only set if the adapter is valid ->
  let foundAt: String
  
  /// if this adapter is currently paired
  @Published var isPaired : Bool
  @Published var isConnected : Bool = false
  @Published var isValid : Bool
  
  @Published var id: String
  var linkType : String
  var portName: String
  
  
  // MARK: Hashable
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  // MARK: Equatable
  static func == (lhs: LinkAdapter, rhs: LinkAdapter) -> Bool {
    return lhs.id == rhs.id
  }
  
  
  init(){
    updateAvailable = false
    updateRequired = true
    firmwareCorrupted = false
    radioUpdateRequired = false
    radioUpdateAvailable = false
    connactionType = .none
    foundAt = "1233"
    isPaired = false
    isConnected = true
    isValid = true
    id="204338635631"
    linkType = "linkAdapter"
    portName = "/dev/cu.usbmodem2043386356311"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    updateAvailable = try container.decode(Bool.self, forKey: .updateAvailable)
    updateRequired = try container.decode(Bool.self, forKey: .updateRequired)
    firmwareCorrupted = try? container.decode(Bool.self, forKey: .firmwareCorrupted)
    radioUpdateRequired = try container.decode(Bool.self, forKey: .radioUpdateRequired)
    radioUpdateAvailable = try container.decode(Bool.self, forKey: .radioUpdateAvailable)
    connactionType = try container.decode(connectionTypes.self, forKey: .connactionType)
    foundAt = try container.decode(String.self, forKey: .foundAt)
    isPaired = try container.decode(Bool.self, forKey: .isPaired)
    isConnected = false
    isValid = try container.decode(Bool.self, forKey: .isValid)
    id = try container.decode(String.self, forKey: .id)
    linkType = try container.decode(String.self, forKey: .linkType)
    portName = try container.decode(String.self, forKey: .portName)
  }
  
  enum CodingKeys: String, CodingKey {
    case updateAvailable = "isDeviceFirmwareUpdateAvailable"
    case updateRequired = "isDeviceFirmwareUpdateRequired"
    case firmwareCorrupted = "isFirmwareCorrupted"
    case radioUpdateAvailable = "isRadioFirmwareUpdateAvailable"
    case radioUpdateRequired = "isRadioFirmwareUpdateRequired"
    case connactionType = "linkConnectionType"
    case foundAt = "initialFoundEpoch"
    case isPaired = "isPairingDone"
    case isValid = "isValid"
    case id = "linkID"
    case linkType = "linkType"
    case portName = "portName"
  }
  
}



// MARK: - MotionControlSystem

class MotionControlSystem: Decodable, Identifiable, ObservableObject, Hashable{
  /// ID of the associated Group if any. Value contains 65535 if not assigned
  @Published var groupID: Int
  
  /// is true if MCS is paired through a canBus 3.2mm connector
  @Published var linkPairigingActive: Bool
  
  /// is true if a HeadOne axis is tilted
  @Published var isTilted: Bool
  /// fix for bug in AIP
  let k:Int
  
  /// the mac-address of the device
  @Published var macAddress: String
  
  /// received signal strength indication
  @Published var rssi: Int
  
  /// is true if a firmeware update is available
  @Published var isFirmewareAvailabe: Bool
  
  /// is true if a radio firmware update is available
  @Published var isRadioUpdateAvailable: Bool
  
  @Published var useInPairing: Bool
  
  // MARK: - Identifiable
  var id:String{
     get {
       return macAddress
     }
  }
  
  // MARK: Hashable
  func hash(into hasher: inout Hasher) {
    hasher.combine(macAddress)
  }
  
  // MARK: Equatable
  static func == (lhs: MotionControlSystem, rhs: MotionControlSystem) -> Bool {
    return lhs.macAddress == rhs.macAddress
  }
  // List of String indication the MCS is a Group Master
  static let masterIndicator = ["panOnly", "tiltOnly", "panTilt", "slideOnly", "dollyOnly", "panAndSlide", "tiltAndSlide", "panAndDolly",
                         "tiltAndDolly", "panTiltAndSlide", "panTiltAndDolly", "panAndJib", "tiltAndJib", "panTiltAndJib",
                         "jibOnly", "panAndJibPlus", "tiltAndJibPlus", "panTiltAndJibPlus", "jibPlusOnly", "followFocusOnly"]
  
  static let memberIndicatores = ["groupMember"]
  
  static let unpaierdIndicators = ["none", "possibleCanbusMaster"]
  /** if the device is a group master this variable contains the capabilities of the group encodeed as a string
   The data combines the possibilites of
   pan, tilt, slide, dolly, jib, jibPlus and followFocus
   There are a couple of combinations that cant be used together
   Dolly,  Slider, jib and jibPlus cant be combined together
   The possible values for a bundle master are:
   
   - panOnly
   - tiltOnly
   - panTilt
   - slideOnly
   - dollyOnly
   - panAndSlide
   - tiltAndSlide
   - panAndDolly
   - tiltAndDolly
   - panTiltAndSlide
   - panTiltAndDolly
   - panAndJib
   - tiltAndJib
   - panTiltAndJib
   - jibOnly
   - panAndJibPlus
   - tiltAndJibPlus
   - panTiltAndJibPlus
   - jibPlusOnly
   - followFocusOnly
   
   if the device is a bundle member the value is
   
   - groupMember
   
   In case the device is not paired yet the possible v aues are:
   
   - none
   - possibleCanbusMaster
   
   Other states are:
   
   - bootingUp
   - firmwareError
   */
  @Published var setup: String
  
  /** Contains  the device Type of the MotionControlSystem
   
   The possible Values are:
   
   - slideModule			Slide Module v2
   - slideModuleV3			Slide Module v3
   - sliderOnePro			SliderONE PRO v2
   - sliderOne			SliderOne v2
   - dollyPlus			Dolly Plus
   - dollyOne			DollyONE
   - dollyPlusPro			DollyPLUS PRO
   - panPro			PanPRO
   - headOne			HeadONE
   - headPlus			HeadPLUS v1
   - headPlusPro			HeadPLUS v1 PRO
   - headPlusV2			HeadPLUS v2
   - headPlusProV2			HeadPLUS v2 PRO
   - focusPlusPro			FocusPLUS PRO
   - jibOne			JibONE
   */
  
  enum edelkroneDevices : String, Decodable{
    case slideModule
    case slideModuleV3
    case sliderOnePro
    case sliderOne
    case dollyPlus
    case dollyOne
    case dollyPlusPro
    case panPro
    case headOne
    case headPlus
    case headPlusPro
    case headPlusV2
    case headPlusProV2
    case focusPlusPro
    case jibOne					
  }
   
  @Published var deviceType: edelkroneDevices
  
  init(){
    groupID = 65535
    linkPairigingActive = false
    isTilted = false
    macAddress = "aa:33:3a:f3:b4:4e"
    rssi = 5
    isFirmewareAvailabe = false
    isRadioUpdateAvailable = false
    setup="none"
    deviceType = .headOne
    isTilted = false
    k=0
    useInPairing = false
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    groupID = try container.decode(Int.self, forKey: .groupID)
    linkPairigingActive = ((try? container.decode(Bool.self, forKey: .linkPairigingActive)) != nil)

    k = (try? container.decode(Int.self, forKey: .k)) ?? 0
    isTilted = k==1

    macAddress = try container.decode(String.self, forKey: .macAddress)
    rssi = try container.decode(Int.self, forKey: .rssi)
    isFirmewareAvailabe = try container.decode(Bool.self, forKey: .isFirmewareAvailabe)
    isRadioUpdateAvailable = try container.decode(Bool.self, forKey: .isRadioUpdateAvailable)
    setup = try container.decode(String.self, forKey: .setup)
    deviceType = try container.decode(edelkroneDevices.self, forKey: .deviceType)
    useInPairing = false
  }
  
  enum CodingKeys: String, CodingKey{
    case groupID = "groupId"
    case linkPairigingActive = "linkPairigingActive"
    case k = "isTilted"
    case macAddress = "mac"
    case rssi = "rssi"
    case isFirmewareAvailabe = "isDeviceFirmwareUpdateAvailable"
    case isRadioUpdateAvailable = "isRadioFirmwareUpdateAvailable"
    case setup = "setup"
    case deviceType = "type"
  }
  
}

protocol ApiResult: Decodable{
  var result: String{get}
  var message:String?{get}
}

struct ResultArrayWrapper<T: Decodable>: Decodable,ApiResult{
  let data: [T]?
  let result: String
  let message: String?
}

// MARK: - PairingGroup
class PairingGroup: Identifiable,ObservableObject, Hashable{

  @Published var groupedControlSystems:[MotionControlSystem] = []
  @Published var groupID : Int = .noGroup // the default nogroup marker

  @Published var groupMaster: MotionControlSystem?
  
  init(groupID: Int){
    self.groupID = groupID
  }
  
  init(){
    self.groupID = Int.random(in: 1000...10000)
    var mcs = MotionControlSystem()
    mcs.groupID = self.groupID
    mcs.setup = "panTilt"
    mcs.deviceType = .headOne
    mcs.macAddress = "24:0A:C4:F2:9F:D2"
    self.groupedControlSystems.append(mcs)
    self.groupMaster = mcs
    
    
    mcs = MotionControlSystem()
    mcs.groupID = self.groupID
    mcs.setup = "groupMember"
    mcs.deviceType = .headOne
    mcs.isTilted = true
    mcs.macAddress = "24:0A:C4:F1:3B:AA"
    self.groupedControlSystems.append(mcs)
    
    
  }
  
  static func == (lhs: PairingGroup, rhs: PairingGroup) -> Bool {
    lhs.groupID == rhs.groupID
  }
  
  var id:Int {
    return groupID
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(groupID)
    for mcs in groupedControlSystems {
      hasher.combine(mcs)
    }
  }
  
  func addMotionControlSystem(_ mcs: MotionControlSystem){
    if (mcs.groupID == self.groupID) && ( !groupedControlSystems.contains(mcs))  {
      groupedControlSystems.append(mcs)
      if MotionControlSystem.masterIndicator.contains(mcs.setup)  {
        groupMaster = mcs
      }
    }
  }
  
  func removeMotionControlSystem(_ mcs:MotionControlSystem){
    if (mcs.groupID == self.groupID) || (mcs.groupID == .noGroup){
      groupedControlSystems.removeAll(where: {$0.macAddress == mcs.macAddress})
      if mcs == groupMaster {
        groupMaster = nil
      }
    }
  }
  var isEmpty:Bool {
    get{
      return groupedControlSystems.isEmpty
    }
  }
}


// MARK: - Return Results
// MARK: Default Returns
struct DefaultReturns: Decodable,ApiResult{
  var result:String
  var message:String?
  
  enum CodingKeys: String, CodingKey{
    case result, message
  }
}

// MARK: PairingStatus
struct PairingStatus:Decodable{
  enum pairingState:String,Decodable{
    case idle,connecting,connectionOk,problem
  }
	var lastPairError: String
  var pairState: pairingState
  
  enum CodingKeys:String, CodingKey{
    case lastPairError
    case pairState = "wirelessPairState"
  }
}

// MARK: PairingStatusReturn
struct PairingStatusReturn:Decodable, ApiResult{
  var result: String
  var message: String?
  let status: PairingStatus?

  enum CodingKeys:String, CodingKey{
    case result, message,status="data"
  }
}

struct AxisDescription:Decodable, Hashable, Equatable, Identifiable{
  var id: ObjectIdentifier = ObjectIdentifier(AxisDescription.self)
  
  enum axisName:String, Decodable{
    case headPan, headTilt, slide, focus, jibPlusPan, jibPlusTilt
  }
  let axis: axisName
  let device: MotionControlSystem.edelkroneDevices
  enum CodingKeys: String, CodingKey{
    case axis,device
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(axis)
  }
  
  static func == (lhs: AxisDescription, rhs: AxisDescription) -> Bool {
    return lhs.axis == rhs.axis
  }
}

struct BundledDeviceInfo:Decodable, Equatable{
  let batteryLevel:Double
  let isTilted:Bool?
  let device:MotionControlSystem.edelkroneDevices
  enum CodingKeys:String,CodingKey{
    case batteryLevel, isTilted, device="type"
  }
  static func == (lhs: BundledDeviceInfo, rhs:BundledDeviceInfo) -> Bool{
    return (lhs.batteryLevel == rhs.batteryLevel) && (lhs.device == rhs.device) && (lhs.isTilted == rhs.isTilted)
  }
}

class PeriodicStatus: Decodable, ObservableObject{
  enum motionState:String, Decodable{
    case idle, keyposeMove, realTimeMove, focusCalibration, sliderCalibration, joystickMove, unsupportedActivity
  }
  @Published var calibratedAxes:[AxisDescription] = []
  @Published var deviceInfo:[BundledDeviceInfo] = []
  @Published var deviceInfoReady:Bool = false
  
  @Published var keyposeLoopActive:Bool = false
  @Published var keyposeMotionAimIndex: Int = -1
  @Published var keyposeMotionStartIndex: Int = -1
  @Published var keyposeSlotsFilled:[Bool] = []
  //
  @Published var plannedMotionProgress: Double = 0.0
  @Published var plannedMotionDuration: Double = 0.0
  @Published var readings:[AxisDescription.axisName:Double] = [:]
  //
  @Published var realTimeSupportedAxes: [AxisDescription] = []
  @Published var state:motionState = .idle
  @Published var supportedAxes:[AxisDescription] = []
  //
  var timestampDevice: Int64
  var timestampEpoch: Int64
  //
  enum CodingKeys:String, CodingKey{
    case calibratedAxes
    case deviceInfo
    case deviceInfoReady = "deviceInfoEverythingReady"
    case keyposeLoopActive, keyposeMotionAimIndex, keyposeMotionStartIndex, keyposeSlotsFilled
    case plannedMotionProgress, plannedMotionDuration, readings
    case realTimeSupportedAxes, state, supportedAxes
        case timestampDevice, timestampEpoch
    
  }
  
  init(){
    timestampDevice = 0
    timestampEpoch = 0
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    calibratedAxes = try container.decode([AxisDescription].self, forKey: .calibratedAxes)
    deviceInfo = try container.decode([BundledDeviceInfo].self, forKey: .deviceInfo)
    deviceInfoReady = try container.decode(Bool.self, forKey: .deviceInfoReady)
    
    keyposeLoopActive = try container.decode(Bool.self, forKey: .keyposeLoopActive)
    keyposeMotionAimIndex = try container.decode(Int.self, forKey: .keyposeMotionAimIndex)
    keyposeMotionStartIndex = try container.decode(Int.self, forKey: .keyposeMotionStartIndex)
    keyposeSlotsFilled = try container.decode([Bool].self, forKey: .keyposeSlotsFilled)
    
    plannedMotionDuration = try container.decode(Double.self, forKey: .plannedMotionDuration)
    plannedMotionProgress = try container.decode(Double.self, forKey: .plannedMotionProgress)
    
    let tempReadings = try container.decode([String:Double].self, forKey: .readings)
    var qreadings:[AxisDescription.axisName:Double] = [:]
    for k in tempReadings.keys{
      let q:AxisDescription.axisName = AxisDescription.axisName(rawValue:k) ?? .headPan
      qreadings[q] = tempReadings[k]
    }
    readings = qreadings
    
    realTimeSupportedAxes = try container.decode([AxisDescription].self, forKey: .realTimeSupportedAxes)
    
    state = try container.decode(motionState.self, forKey: .state)
    
    supportedAxes = try container.decode([AxisDescription].self, forKey: .supportedAxes)
    timestampEpoch = try container.decode(Int64.self, forKey: .timestampEpoch)
    timestampDevice = try container.decode(Int64.self, forKey: .timestampDevice)
  }
  
  static func &= (lhs:PeriodicStatus,rhs:PeriodicStatus){
    if lhs.calibratedAxes != rhs.calibratedAxes{
      lhs.calibratedAxes = rhs.calibratedAxes
    }
    if lhs.deviceInfo != rhs.deviceInfo{
      lhs.deviceInfo = rhs.deviceInfo
    }
    
    if lhs.deviceInfoReady != rhs.deviceInfoReady{
      lhs.deviceInfoReady = rhs.deviceInfoReady
    }
    
    if lhs.keyposeLoopActive != rhs.keyposeLoopActive{
      lhs.keyposeLoopActive = rhs.keyposeLoopActive
    }
    
    if lhs.keyposeMotionAimIndex != rhs.keyposeMotionAimIndex{
      lhs.keyposeMotionAimIndex = rhs.keyposeMotionAimIndex
    }
    
    if lhs.keyposeMotionStartIndex != rhs.keyposeMotionStartIndex{
      lhs.keyposeMotionStartIndex = rhs.keyposeMotionStartIndex
    }
    
    if lhs.keyposeSlotsFilled != rhs.keyposeSlotsFilled{
      lhs.keyposeSlotsFilled = rhs.keyposeSlotsFilled
    }
    
    if lhs.plannedMotionProgress != rhs.plannedMotionProgress{
      lhs.plannedMotionProgress = rhs.plannedMotionProgress
    }
    
    if lhs.plannedMotionDuration != rhs.plannedMotionDuration{
      lhs.plannedMotionDuration = rhs.plannedMotionDuration
    }
    
    if lhs.readings != rhs.readings {
      lhs.readings = rhs.readings
    }
    
    if lhs.realTimeSupportedAxes != rhs.realTimeSupportedAxes{
      lhs.realTimeSupportedAxes = rhs.realTimeSupportedAxes
    }
    if lhs.state != rhs.state{
      lhs.state = rhs.state
    }
    if lhs.supportedAxes != rhs.supportedAxes{
      lhs.supportedAxes = rhs.supportedAxes
    }
    
//    if lhs.timestampEpoch != rhs.timestampEpoch{
//      lhs.timestampEpoch = rhs.timestampEpoch
//    }
//    if lhs.timestampDevice != rhs.timestampDevice{
//      lhs.timestampDevice = rhs.timestampDevice
//    }
  }
}

struct PeriodicStatusReturn: Decodable, ApiResult{
  var result: String
  var message: String?
  let status: PeriodicStatus
  enum CodingKeys:String, CodingKey{
    case result, message, status = "data"
  }
}
