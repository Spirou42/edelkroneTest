//
//  ModelTypes.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 07.03.22.
//

import Foundation

// MARK: - LinkAdapter
struct LinkAdapter{
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
  var isPaired : Bool
  var isValid : Bool
  var id: String
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
    isValid = true
    id="204338635631"
    linkType = "linkAdapter"
    portName = "/dev/cu.usbmodem2043386356311"
  }
}

extension LinkAdapter: Decodable{
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

struct MotionControlSystem{
  /// ID of the associated Group if any. Value contains 65535 if not assigned
  let groupID: Int

  /// is true if MCS is paired through a canBus 3.2mm connector
  let linkPairigingActive: Bool
  
  /// is true if a HeadOne axis is tilted
  let isTilted: Bool
  
  /// the mac-address of the device
  let macAddress: String
  
  /// received signal strength indication
  let rssi: Int
  
  /// is true if a firmeware update is available
  let isFirmewareAvailabe: Bool
  
  /// is true if a radio firmware update is available
  let isRadioUpdateAvailable: Bool
  
  /** if the device is a group master this variable contains the capabilities of the group encodeed as a string

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
  let setup: String
  
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
  
}

extension MotionControlSystem: Decodable{
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


struct arrayWrapper<T: Decodable>: Decodable{
  let data: [T]
//  let result: String
}
