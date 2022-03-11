/**
  edelkroneModels.swift
  edelkroneTest
	
 Containing basic models for api results
 
  Created by Carsten Müller on 07.03.22.
 */

import Foundation

// MARK: - LinkAdapter
class LinkAdapter: Identifiable,Decodable, ObservableObject{
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

class MotionControlSystem: Decodable, Identifiable, ObservableObject{
  /// ID of the associated Group if any. Value contains 65535 if not assigned
  @Published var groupID: Int
  
  /// is true if MCS is paired through a canBus 3.2mm connector
  @Published var linkPairigingActive: Bool
  
  /// is true if a HeadOne axis is tilted
  @Published var isTilted: Bool
  
  /// the mac-address of the device
  @Published var macAddress: String
  
  /// received signal strength indication
  @Published var rssi: Int
  
  /// is true if a firmeware update is available
  @Published var isFirmewareAvailabe: Bool
  
  /// is true if a radio firmware update is available
  @Published var isRadioUpdateAvailable: Bool
  

  
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
   let deviceType: String
  
  init(){
    groupID = 65535
    linkPairigingActive = false
    isTilted = false
    macAddress = "aa:33:3a:f3:b4:4e"
    rssi = 5
    isFirmewareAvailabe = false
    isRadioUpdateAvailable = false
    setup="none"
    deviceType = "sliderOne"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    groupID = try container.decode(Int.self, forKey: .groupID)
    linkPairigingActive = try container.decode(Bool.self, forKey: .linkPairigingActive)
    isTilted = try container.decode(Bool.self, forKey: .isTilted)
    macAddress = try container.decode(String.self, forKey: .macAddress)
    rssi = try container.decode(Int.self, forKey: .rssi)
    isFirmewareAvailabe = try container.decode(Bool.self, forKey: .isFirmewareAvailabe)
    isRadioUpdateAvailable = try container.decode(Bool.self, forKey: .isRadioUpdateAvailable)
    setup = try container.decode(String.self, forKey: .setup)
    deviceType = try container.decode(String.self, forKey: .deviceType)
  }
  
  enum CodingKeys: String, CodingKey{
    case groupID = "groupId"
    case linkPairigingActive = "linkPairigingActive"
    case isTilted = "isTilted"
    case macAddress = "mac"
    case rssi = "rssi"
    case isFirmewareAvailabe = "isDeviceFirmwareUpdateAvailable"
    case isRadioUpdateAvailable = "isRadioFirmwareUpdateAvailable"
    case setup = "setup"
    case deviceType = "type"
  }
  
}



struct resultArrayWrapper<T: Decodable>: Decodable{
  let data: [T]
  //  let result: String
}
