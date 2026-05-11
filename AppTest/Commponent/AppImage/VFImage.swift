//
//  VFImage.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 08/02/2026.
//

import Kingfisher
import SwiftUI

/// View for static images or from network
public struct VFImage: View {
    var name: String?
    var url: URL?
    let width: CGFloat?
    let maxWidth: CGFloat?
    let height: CGFloat?
    let maxHeight: CGFloat?
    var placeholder: String?
    let contentMode: SwiftUI.ContentMode
    var backgroundColor: Color?
    
    
    @State private var isLoading = false

    public init(name: String,
         width: CGFloat? = .none,
         maxWidth: CGFloat? = .none,
         height: CGFloat? = .none,
         maxHeight: CGFloat? = .none,
         contentmode: SwiftUI.ContentMode = .fit,
                backgroundColor: Color = Color.clear)
    {
        self.name = name
        self.url = nil
        self.width = width
        self.maxWidth = maxWidth
        self.height = height
        self.maxHeight = maxHeight
        self.contentMode = contentmode
        self.backgroundColor = backgroundColor
    }

    public init(url: URL,
         placeholder: String? = nil,
         width: CGFloat? = .none,
         maxWidth: CGFloat? = .none,
         height: CGFloat? = .none,
         maxHeight: CGFloat? = .none,
         contentmode: SwiftUI.ContentMode = .fit)
    {
        self.name = nil
        self.url = url
        self.width = width
        self.maxWidth = maxWidth
        self.height = height
        self.maxHeight = maxHeight
        self.contentMode = contentmode
        self.placeholder = placeholder
    }
    
    public init(urlString: String,
         placeholder: String? = nil,
         width: CGFloat? = .none,
         maxWidth: CGFloat? = .none,
         height: CGFloat? = .none,
         maxHeight: CGFloat? = .none,
         contentmode: SwiftUI.ContentMode = .fit)
    {
        self.name = nil
        self.url = URL(string: urlString)
        self.width = width
        self.maxWidth = maxWidth
        self.height = height
        self.maxHeight = maxHeight
        self.contentMode = contentmode
        self.placeholder = placeholder
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(backgroundColor ?? Color.clear)
                .frame(width: width, height: height)
            
            Group{
                if let name = name {
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                        .frame(width: width, height: height)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                        .clipped()
                }
                else if let url = url {
                    GeometryReader { geo in
                        KFImage(url)
                            .onSuccess { _ in
                                isLoading = false
                            }
                            .onFailure { _ in
                                isLoading = placeholder == nil ? true : false
                            }
                            .placeholder {
                                if let placeholder {
                                    Image(placeholder)
                                        .resizable()
                                        .aspectRatio(contentMode: contentMode)
                                        .clipped()
                                }
                            }
                            .fade(duration: 1)
                            .forceTransition()
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .AppShimmering(on: $isLoading)
                        // .redacted(reason: isLoading ? .placeholder : [])
                            .onFirstAppear {
                                isLoading = true
                            }
                        
                    }
                    .frame(width: width, height: height)
                    .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                    .clipped()
                }
            }
        }
    }
}

#Preview {
    @State var isLoading: Bool = true
    VStack{
 
        //Image from App Assets
        VFImage(name: "AppIconeLight",width: 100, height: 100,backgroundColor: .red)
        
        // Image from URL
        VFImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRWBC6C3Zj0P61_H8gT5lhbJDmQTNpSLW4Ow&s")!,
                placeholder: "empty-credit-cards",
                width: 200,
                height: 200)
        
        // Image from URL in string format
        VFImage(urlString:"https://play-lh.googleusercontent.com/9bD0Q8kdwgG0scxWPhuaQL4ph4h_GkzGJPC2Vxm0T8vncjwIayMA2QXyrSTZVHNXMuU",
                width: 100,
                height: 100)

    }
    //.AppShimmering(on: $isLoading)
    //.redacted(reason: .placeholder)
    
}

