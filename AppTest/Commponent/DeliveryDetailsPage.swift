//
//  DeliveryDetailsPage.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 19/05/2025.
//
import SwiftUI

struct DeliveryDetailsPage: View {
    let width = UIScreen.main.bounds.width * 0.5
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(spacing: 16) {
            
                workHoursCard
               
            }
        }
        .background(Color.gray.opacity(0.2))
    }
}

#Preview{
    DeliveryDetailsPage()
}

extension DeliveryDetailsPage{
    var header: some View{
        HStack(alignment: .top, spacing: 12) {
            Image("truck")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 36)

            VStack(alignment: .leading) {
                Text("Free delivery on orders above 50 SAR")
                    .lineLimit(2)
                Text("Delivery cost is 17 SAR for other orders")
                    .lineLimit(2)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(radius: 20, corners: [.bottomLeft, .bottomRight])

    }
    
    
    var workHoursCard: some View{
        HStack(alignment: .top, spacing: 0) {
            Image("deliveryTruck")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .padding(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Package delivery work hours")
                    .padding(.top,10)
                
                Text("Saturday to Thursday From 8 AM to 2 AM")
                    .padding(.top)
                    .lineLimit(2)
                    .minimumScaleFactor(0.9)
                Divider()
                Text("Friday From 2 PM to 11 AM")
                    .padding(.bottom)
                    .minimumScaleFactor(0.7)
            }
            
            Image("group3")
                .resizable()
                .cornerRadius(10)
//                .scaledToFill()
            
               
        }
       // .frame(height: 250)
        .cardBackground()
       // .clipped()
        .padding()
    }
    
    var workHoursCard2: some View{
        ZStack{
            Image("adAssets02")
                .resizable()
                .scaledToFit()
                .clipped()
            
            HStack(alignment: .top, spacing: 10) {
                Image("deliveryTruck")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                   // .padding(.leading,10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Package delivery work hours")
                    //Spacer()
                    Text("Saturday to Thursday From 8 AM to 2 AM")
                         //.frame(width:  300)
                   // Divider().frame(width:  width)
                    Text("Friday From 2 PM to 11 AM")
                        // .frame(width:  width)
                    
                    Spacer()
                }
                
                    //Spacer()
            }.padding(.top,40)
        }
    }
    
    var deliveryRegion: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Delivery region")
                
            Text("Damman, Khobar, Hofuf, Jubail, Hafr Al-Baten, Ras Tanura and 20 more cities")
                .lineLimit(2)
            
            
        }
    }
}



extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}



