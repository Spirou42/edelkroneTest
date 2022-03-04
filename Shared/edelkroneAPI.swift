//
//  edelkroneInterface.swift
//  edelkroneTest (macOS)
//
//  Created by Carsten Müller on 04.03.22.
//

import Foundation
import SwiftUI

class edelkroneModel : ObservableObject{
  static let shared = edelkroneModel()
  
  // flag to determine if the link to the edelkrone API is established
  @Published var isConnected : Bool = false
  
  @AppStorage(Preferences.Hostname.rawValue) private  var hostname = ""
  @AppStorage(Preferences.Port.rawValue) private var port = 8080
  @AppStorage(Preferences.LinkAdapter.rawValue) private var linkID = ""
  
  
  func dummyDumm(){
    print("DummyDummDumm")
  }
  
  func connect() -> Void{
    print ("Initiate Scan on" + hostname+":"+String(port)+"/v1/link/"+linkID)
    var t = getCommand(command: edelkroneCommands.pairing.wirelessPairingScanStart.rawValue)
    
    var q : Data = Data()
    do{
      q = try JSONSerialization.data(withJSONObject: t, options:.prettyPrinted)
    }catch{
    	q = Data()
    }
    
    print("Babelfisch: " + (String(data: q, encoding: .utf8) ?? "Failed"))
  }
  
  func getCommand(command: String) -> Dictionary<String, Any>{
    var someDict:Dictionary = ["command": command]
    return someDict
  }
  
  
}
 
