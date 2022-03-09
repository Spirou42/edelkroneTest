/**
 edelkroneAPI.swift
 edelkroneTest
 
 Created by Carsten Müller on 04.03.22.
 */

import Foundation
import SwiftUI

protocol commandEnum {}

/**
 encapsulates the edelkrone API calls and is the single point of information for the application
 */
class edelkroneModel : ObservableObject{
  static let shared = edelkroneModel()
  
  /// Model for a single edelkrone LinkAdapter
  
  
  enum commands : String, commandEnum {
    enum pairing {
      enum wireless : String, commandEnum {
        case scanStart = "wirelessPairingScanStart",
             scanResults = "wirelessPairingScanResults",
             createBundle = "wirelessPairingCreateBundle",
             attachToBundle = "wirelessPairingAttachToBundle",
             status = "wirelessPairingStatus",
             disconnect
      }
      enum linked : String, commandEnum {
        case scanResults = "link2PairingScanResults",
             connect = "link2PairingConnect",
             status = "link2PairingStatus",
             disconnect
      }
    }
    enum keypose : String, commandEnum {
      case storeCurrentPose = "keyposeStoreCurrentPose",
           storeWithNumericData = "keyposeStoreWithNumericData",
           moveFixedDuration = "keyposeMoveFixedDuration",
           moveFixedSpeed = "keyposeMoveFixedSpeed",
           loopFixedDuration = "keyposeLoopFixedDuration",
           loopFixedSpeed = "keyposeLoopFixedSpeed",
           readNumericValues = "keyposeReadNumericValues",
           delete  = "keyposeDeletePose"
    }
    enum realTimeMove : String, commandEnum {
      case fixedDuration = "realTimeMoveFixedDuration"
    }
    case joystickMove = "joystickMove"
    case focusMove = "focusManualMove"
    case motionAbort = "motionAbort"
    case calibrate = "calibrate"
    case status = "status"
    enum link : String, commandEnum {
      case status = "linkStatus",
           detect = "detect"
      // the firmeware update command like: startLinkDeviceFirmwareUpdate, linkDeviceFirmwareUpdateStatus, startLinkRadioFirmwareUpdate, linkRadioFirmwarUpdateStatus are unsuported
    }
    case shutter = "shutterTrigger"
  }
  
  enum requestType : String {
    case link, bundle, device
  }
  
  var adapters: [LinkAdapter] = []		// list of deteced LinkAdapters
  
  // flag to determine if the link to the edelkrone API is established
  @Published var isConnected : Bool = false
  @Published var isPaired : Bool = false
  @Published var hasAdapters : Bool = false
  
  // Variables from Preferences
  @AppStorage(Preferences.Hostname.rawValue) private  var hostname = ""
  @AppStorage(Preferences.Port.rawValue) private var port = 8080
  @AppStorage(Preferences.LinkAdapter.rawValue) private var linkID = ""
  
  
  func findLinkAdapters() -> Void{
    print("Initiate Scan for LinkAdapters on" + hostname + ":"+String(port) )
    let requestDict = getCommand(commands.link.status.rawValue)
    if let requestURL = getRequestURL(.device){
      let requestData = commandToJSON(_commandDict: requestDict)
      var request = URLRequest(url: requestURL)
      request.httpMethod="POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = requestData
      
      let task = URLSession.shared.uploadTask(with: request, from: requestData, completionHandler:{ (data, response, error)->Void in
        guard let data = data else{
          print("No Data")
          self.hasAdapters = false
          return
        }
        print("Data: " + (String(data: data, encoding: .utf8) ?? "convert Failed") )
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(arrayWrapper<LinkAdapter>.self, from: data)
        print ("Decoded"+(wrapper?.data.description ?? "nothing"))
        if(wrapper != nil){
          self.hasAdapters = true
          self.adapters = wrapper!.data
        }
      }
      )
      task.resume()
    }
  }
  
  func dummyDumm(){
    print("DummyDummDumm")
  }
  
  func connect() -> Void{
    print ("Initiate Scan on" + hostname+":"+String(port)+"/v1/link/"+linkID)
    let requestStruct = getCommand(commands.pairing.wireless.scanStart.rawValue)
    //    requestStruct["index"] = 0
    //    requestStruct["acceleration"] = 0.0
    //    requestStruct["speed"] = 1.0
    
    let data: Data =  commandToJSON(_commandDict: requestStruct) ?? Data()
    if let requestURL = getRequestURL(.link){
      var request = URLRequest(url: requestURL)
      request.httpMethod = "POST"
      request.httpBody=data
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      print("Babelfisch: " + (String(data: data, encoding: .utf8) ?? "Failed"))
      let description = requestURL.description
      print("Request from " + description )
      createSession(request: request, uploadData: data)
      isConnected = true
    }else{
      isConnected = false
    }
  }
  
  
  func createSession(request: URLRequest, uploadData: Data){
    let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
      if let error = error {
        print ("error: \(error)")
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        print ("server error " )
        return
      }
      if let mimeType = response.mimeType{
        //mimeType == "application/json"
        let data = data ?? Data()
        let dataString = String(data: data, encoding: .utf8)
        print ("got data: \(dataString!)")
      }
    }
    task.resume()
  }
  
  func disconnect() -> Void{
    isConnected = false
  }
  
  func linkStatus() -> Void{
    
  }
  
  
  private func getCommand(_ command :String ) -> Dictionary<String, Any>{
    let someDict:Dictionary = ["command": command]
    return someDict
  }
  
  private func commandToJSON(_commandDict: Dictionary<String, Any>) -> Data?{
    var result : Data? = nil
    do{
      result = try JSONSerialization.data(withJSONObject: _commandDict, options: .prettyPrinted)
    }catch{
      result = nil
    }
    return result
  }
  
  private func getRequestURL(_ type: requestType ) -> URL?{
    @AppStorage(Preferences.Hostname.rawValue)   var hostname = ""
    @AppStorage(Preferences.Port.rawValue)  var port = 8080
    @AppStorage(Preferences.LinkAdapter.rawValue)  var linkID = ""
    
    let base = "http://"+hostname+":"+String(port)+"/v1/"
    var variant  = type.rawValue
    if (type != requestType.device){
      variant += linkID
    }
    
    let p = URL(string: base+variant)
    return p
  }
  
}

