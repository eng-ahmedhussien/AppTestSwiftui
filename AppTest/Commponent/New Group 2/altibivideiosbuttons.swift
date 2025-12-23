//
//  altibivideiosbuttons.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 16/12/2025.
//

import SwiftUI

struct altibivideiosbuttons: View {
    @State var isVideoEnabled = false
    @State var isMuted = false
    
    var body: some View {
        VStack{
                // Control Buttons
            HStack(spacing: 10) {
                    // Mute Button
                
                
                Button {
                    isMuted.toggle()
                } label: {
                    VStack{
                        Image(isMuted ? "Unmute" : "Mute")
                            .resizable()
                            .frame(width: 56, height: 56)
                        
                        Text("Mute")
                        
                            .foregroundColor(.white)
                    }
                }
                
                
                
                    // Switch Camera Button
                Button{ print("")
                }label: {
                    VStack{
                        Image("flip")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 56, height: 56)
                            // viewModel.isUsingFrontCamera
                        Text( "flip")
                        
                            .foregroundColor(.white)
                    }
                }
                
                    // Toggle Video Button
                Button{ isVideoEnabled.toggle()}
                label:{
                    VStack{
                        Image(isVideoEnabled ? "closevideo" : "video" )
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: isVideoEnabled ? 56 : 70, height: isVideoEnabled ? 50 : 70)
                           
                        Text("video")
                        
                            .foregroundColor(.white)
                    }
                    
                }
                
                    // End Call Button
                Button{  print("")}
                label:{
                    VStack{
                        Image("end")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 56, height: 56)
                        
                        Text("End")
                        
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .background(Color.black)
       
    }
}

#Preview {
    altibivideiosbuttons()
}
