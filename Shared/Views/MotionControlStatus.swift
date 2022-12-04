//
//  MotionControlStatus.swift
//  edelkroneTest
//
//  Created by Carsten Müller on 01.04.22.
//


import SwiftUI
import edelkroneAPI
import Extensions

// MARK: - BatteryView -

struct BatteryView: View{
  var level:Double
  static var batteryImages:[Image] = [Image("Icons/Battery 0"),Image("Icons/Battery 1"),Image("Icons/Battery 2"),Image("Icons/Battery 3"), Image("Icons/Battery 4")]
  var batteryImage:Image {
    get {
      var image = BatteryView.batteryImages[0]
      if level >= 0.2 { image =  BatteryView.batteryImages[1]}
      if level >= 0.4 { image =  BatteryView.batteryImages[2]}
      if level >= 0.7 { image =  BatteryView.batteryImages[3]}
      if level >= 0.9 { image =  BatteryView.batteryImages[4]}
      return image
    }
  }
  
  var body: some View{
    let wi = 40.0
    ZStack{
      //.resizable(capInsets: EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 8  ),resizingMode: .stretch)
      //.aspectRatio(CGSize(width: 364, height: 205), contentMode: .fill)
      // Color(white: 1.0, opacity: 0.8)
      batteryImage.resizable().aspectRatio(CGSize(width: 364, height: 205), contentMode: .fit)
      ZStack{
        //String(format: "%3d %%",arguments: Int(level*100) )
//        Text("")
//          .font(.applicationFont(.caption).weight(.bold)).monospacedDigit().foregroundColor(.black)
//          .viewBorder(color: .darkWhite, radius: 0.2, outline: false)
        Text( String(format: "%3d%%", Int(level*100) ) )
          .font(.applicationFont(.caption).weight(.bold)).monospacedDigit().foregroundColor(.black)
          .viewBorder(color: .darkWhite, radius: 0.2, outline: false)
      }
      .padding([.leading],-4)
      .padding([.top],1)
      
    }.frame(width: wi, height: wi * 0.5631)
  }
}


struct BatteryView_Previews: PreviewProvider {
  static var previews: some View {
    BatteryView(level: 0.7)
  }
}

// MARK: - MCSStatus -

struct MCSStatus:View{
  let buttonSize:CGFloat = Font.applicationFontSize(.title2)
  let buttonPadding:CGFloat = 5.0
  
  @ObservedObject var mcsState:MotionControlStatus
  var columns: [GridItem] = [.init(.flexible(minimum: 20, maximum: 70),spacing:0.5,alignment:.trailing ),
                             .init(.flexible(minimum: 20, maximum: 80),spacing:0.5,alignment:.leading ),
                             .init(.flexible(minimum: 20, maximum: 100),spacing:0.5,alignment:.leading ),
                             .init(.flexible(minimum: 20, maximum: 80), spacing:0.5, alignment: .trailing)
  ]
  
  var body: some View {
    ZStack{
      Rectangle().fill(Color.lightGray)
      VStack(alignment: .leading, spacing: 4){
        VStack(alignment: .leading,spacing: 0) {
          VStack(alignment: .leading, spacing: 3){
            Text("Status: ").font(.applicationFont(.title2).weight(.semibold))
            Text(mcsState.state.toString()).font(.applicationFont(.title2))
          }.padding([.top],4)
            .padding([.bottom],8)
        }.fixedSize(horizontal: false, vertical: true)
        Divider()
        LazyVGrid(columns: columns, alignment:.trailing, spacing:0.5) {
          ZStack(alignment: .center){
            Rectangle().fill(Color.lightGray)
            Text("Axel").font(.applicationFont(.title2).weight(.semibold)).padding(2)
          }
          ZStack{
            Rectangle().fill(Color.lightGray)
            Text("Battery").font(.applicationFont(.title2).weight(.semibold)).padding(2)
          }
          ZStack{
            Rectangle().fill(Color.lightGray)
            Text("Position").font(.applicationFont(.title2).weight(.semibold)).padding(2)
          }
          ZStack{
            Rectangle().fill(Color.lightGray)
            Text("Cal.").font(.applicationFont(.title2).weight(.semibold)).padding(2)
          }
          
          ForEach( Array(mcsState.axelStatus.keys).sorted(by: {(lhs:AxelID, rhs:AxelID) in return lhs<rhs }) ,id:\.self){ c in
            ZStack(alignment: .center){
              Rectangle().fill(Color.lightLightGray)
              Text( c.toString()).font(.applicationFont(.title3)).padding(2)
            }.frame(height:26.52)
            ZStack(alignment: .center){
              Rectangle().fill(Color.lightLightGray)
              BatteryView(level: mcsState.axelStatus[c]!.batteryLevel).padding(2)
            }.frame(height:26.52)
            ZStack(alignment: .center){
              Rectangle().fill(Color.lightLightGray)
              Text(String(format:"%03.03f",mcsState.axelStatus[c]!.position)).font(.applicationFont(.title3).weight(.regular)).monospacedDigit()
            }.frame(height:26.52)
            ZStack(alignment: .center){
              Rectangle().fill(Color.lightLightGray)
              if(mcsState.axelStatus[c]!.canCalibrate){
                Button(action:{edelkroneAPI.shared.calibrate(mcsState.axelStatus[c]!)}){
                  Text("Calibrate")
                    .font(.applicationFont(.caption))
                }.buttonStyle(GradientGlyphButtonStyle(buttonColor: mcsState.axelStatus[c]!.needsCalibration ? Color.Theme.RedLighter : Color.Theme.GreenLighter,
                                                       cornerRadius: 3.0,
                                                       shadowRadius:0.0,
                                                       width: 40.0,
                                                       height: 19.0,
                                                       bevelSize: 4.0
                                                      ))
              }
              
            }.frame(height:26.52)
          }
        }.frame(minWidth:220,idealWidth:280, maxWidth:400, maxHeight:.infinity)
          .fixedSize(horizontal: true, vertical: true)
          //.border(.orange, width: 1.0, edges: Edge.allCases)
          .background(.gray)
        
        Divider()
        Spacer()
        HStack{
          Spacer()
          
          Button(action: {edelkroneAPI.shared.reset()}){
            Text("Disconnect")
              .font(.applicationFont(.title2))
              .frame(maxWidth:.infinity, alignment: .center)
            
          }.buttonStyle(GradientGlyphButtonStyle(buttonColor:   Color.Theme.Red,
                                                 cornerRadius: 7,
                                                 shadowRadius: 0,
                                                 glyph:Text("\u{22f2}")
            .font(.custom("Symbols-Regular", size: buttonSize+10)),
                                                 glyphPadding: 10,
                                                 width: 140,
                                                 height: 50,
                                                 bevelSize: 3.0
                                                ))
          .padding([.trailing],5).padding([.bottom],5)
        }
				
        HStack{
          Spacer()
          Button( action: {edelkroneAPI.shared.disconnect()}){
            Text("Unpair")
              .font(.applicationFont(.title2))
              .frame(maxWidth:.infinity, alignment: .center)
          }
          .buttonStyle(GradientGlyphButtonStyle(buttonColor:   Color.Theme.Green,
                                                cornerRadius: 7,
                                                shadowRadius: 0,
                                                glyph:Text("\u{22f4}")
            .font(.custom("Symbols-Regular", size: buttonSize+10)),
                                                glyphPadding: 10,
                                                width: 140,
                                                height: 50,
                                                bevelSize: 3.0
                                               ))
          .padding([.trailing],5).padding([.bottom],5)
        }
        
      }.padding([.leading],5)
    }.frame(minWidth: 200, idealWidth:250, maxHeight:.infinity)
      .fixedSize(horizontal: true, vertical: true)
  }
  
  var otherBody: some View {
    VStack(alignment: .trailing){
      LazyVGrid(columns: columns, alignment:.trailing, spacing:0.5) {
        ZStack(alignment: .center){
          Rectangle().fill(Color.lightGray)
          Text("Axel").font(.applicationFont(.title).weight(.bold)).padding(2)
        }
        ZStack{
          Rectangle().fill(Color.lightGray)
          Text("Position").font(.applicationFont(.title).weight(.bold)).padding(2)
        }
        ZStack{
          Rectangle().fill(Color.lightGray)
          Text("Battery").font(.applicationFont(.title).weight(.bold)).padding(2)
        }
        
        ForEach( Array(mcsState.axelStatus.keys) ,id:\.self){ c in
          ZStack(alignment: .center){
            Rectangle().fill(Color.lightLightGray)
            Text( c.toString()).font(.applicationFont(.body)).padding(2)
          }.frame(height:26.52)
          ZStack(alignment: .center){
            Rectangle().fill(Color.lightLightGray)
            Text(String(format:"%03.03f",mcsState.axelStatus[c]!.position)).monospacedDigit()
            
          }.frame(height:26.52)
          ZStack(alignment: .center){
            Rectangle().fill(Color.lightLightGray)
            BatteryView(level: mcsState.axelStatus[c]!.batteryLevel).padding(2)
          }
        }
      }
      .frame(minWidth:200,idealWidth:300, maxWidth:400, maxHeight:.infinity)
      .fixedSize(horizontal: true, vertical: true)
      .border(.orange, width: 2, edges: Edge.allCases)
      .background(.gray)
      
      HStack{
        Spacer()
        Button( action: {edelkroneAPI.shared.disconnect()}){
          Text("Unpair")
            .font(.applicationFont(.title2))
            .frame(maxWidth:.infinity, alignment: .center)
        }
        .buttonStyle(GradientGlyphButtonStyle(buttonColor: Color.Theme.Green,
                                              cornerRadius: 7,
                                              glyph:Text("\u{22f4}")
          .font(.custom("Symbols-Regular", size: buttonSize+10)),
                                              glyphPadding: 10,
                                              width: 140,
                                              height: 50,
                                              bevelSize: 3.0
                                             ))
        //.padding([.trailing],5).padding([.bottom],5)
      }
      HStack{
        Spacer()
        Button(action: {edelkroneAPI.shared.reset()}){
          Text("Disconnect")
            .font(.applicationFont(.title2))
            .frame(maxWidth:.infinity, alignment: .center)
          
        }.buttonStyle(GradientGlyphButtonStyle(buttonColor:   Color.Theme.Red,
                                               cornerRadius: 7,
                                               glyph:Text("\u{22f2}")
          .font(.custom("Symbols-Regular", size: buttonSize+10)),
                                               glyphPadding: 10,
                                               width: 140,
                                               height: 50,
                                               bevelSize: 3.0
                                              ))
        // .padding([.trailing],5).padding([.bottom],5)
      }
    }
  }
}

struct MCSStatus_Previews: PreviewProvider {
  static var motionControlStatus = edelkroneAPI.shared.motionControlStatus
  static var previews: some View {
    MCSStatus(mcsState:motionControlStatus).frame(width:800)
  }
}
