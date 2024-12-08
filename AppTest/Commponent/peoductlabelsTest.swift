//
//  peoductlabelsTest.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 24/10/2024.
//

import SwiftUI

struct peoductlabelsTest: View {
    var body: some View {
        //        HStack{
        //            VStack{
        //                Image(systemName: "lasso")
        //                    .resizable()
        //                    .frame(width: 120,height: UIScreen.main.bounds.height / 6)
        //                    .border(.red)
        //                    .overlay{
        //                        VStack{
        //                            Image(systemName: "square.and.arrow.up.circle.fill")
        //                                .padding(2)
        //                                .alignVertically(.top,10)
        //                                .alignHorizontally(.leading,10)
        //
        //
        //                            Image(systemName: "square.and.arrow.up.circle.fill")
        //                                .resizable()
        //                                .frame(width: 20, height: 20)
        //                                .alignVertically(.center,10)
        //                                .alignHorizontally(.leading,10)
        //
        //
        //                            Text("20%")
        //                                .font(.caption2)
        //                                .frame(width: 30, height: 30)
        //                                .foregroundColor(Color.white)
        //                                .background(Color.red)
        //                                .clipShape(Circle())
        //                                .alignVertically(.bottom)
        //                                .alignHorizontally(.leading,10)
        //
        //                            Image(systemName: "square.and.arrow.up.circle.fill")
        //                                .resizable()
        //                                .frame(width: 20, height: 20)
        //                                .frame(maxWidth: .infinity, alignment: .trailing)
        //
        //                        }
        //                    }
        //                //.clipped()
        //
        //                VStack{
        //                    Text("panadoel")
        //                    Text("29.0")
        //                    Text("panadoel sometext")
        //                }
        //                .frame(height: 160)
        //                .padding()
        //
        //            }
        //            .frame(height: 360)
        //            .cardBackground(color: .white, cornerRadius: 20, shadowRadius: 5, shadowColor: .gray.opacity(0.5))
        //            .border(.green)
        
        ///
        VStack{
            VStack{
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .padding(2)
                    .alignVertically(.top,10)
                    .alignHorizontally(.leading,10)
                
                
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .alignVertically(.center,10)
                    .alignHorizontally(.leading,10)
                
                
                Text("20%")
                    .font(.caption2)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .clipShape(Circle())
                    .alignVertically(.bottom)
                    .alignHorizontally(.leading,10)
                
                Image(systemName: "square.and.arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
             .frame(width: 200,height: UIScreen.main.bounds.height / 6)
            .background{
                Image(systemName: "lasso")
                    .frame(width: 200,height: UIScreen.main.bounds.height / 6)
                    .frame(maxWidth:.infinity)
                    .border(.red)
            }
            
            VStack{
                Text("panadoel")
                Text("29.0")
                Text("panadoel sometext")
            }
            .frame(height: 160)
            
            .padding()
        }
        .cardBackground(color: .white, cornerRadius: 20, shadowRadius: 5, shadowColor: .gray.opacity(0.5))
        
    }
        
}


#Preview {
    peoductlabelsTest()
}


extension View {
    func cardBackground(color: Color = Color.white,
                        cornerRadius: CGFloat = 10,
                        shadowRadius: CGFloat = 0,
                        shadowColor: Color = Color.clear,
                        shadowX: CGFloat = 0,
                        shadowY: CGFloat = 0) -> some View {
        modifier(CardBackground(color: color,
                                cornerRadius: cornerRadius,
                                shadowRadius: shadowRadius,
                                shadowColor: shadowColor,
                                shadowX: shadowX,
                                shadowY: shadowY))
    }
}

struct CardBackground: ViewModifier {
    let color: Color
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let shadowColor: Color
    let shadowX : CGFloat
    let shadowY : CGFloat

    init(color: Color = Color.white,
         cornerRadius: CGFloat = 10,
         shadowRadius: CGFloat = 0,
         shadowColor: Color = Color.clear,
         shadowX: CGFloat = 0,
         shadowY: CGFloat = 0) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.shadowX = shadowX
        self.shadowY = shadowY
    }
    

    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color)
                    .shadow(color: shadowColor, radius: shadowRadius,x:shadowX ,y: shadowY)
            }
            
    }
}
