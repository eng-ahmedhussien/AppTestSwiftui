//
//  SegmentedView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 21/04/2025.
//

import SwiftUI

struct SegmentedView: View {

    let segments: [String] = ["OPEN", "COMPLETED", "CANCELLED", "ALL"]
    @State private var selected: String = "OPEN"
    @Namespace var name

    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selected = segment
                } label: {
                    VStack {
                        Text(segment)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(selected == segment ? .green : Color(uiColor: .systemGray))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selected == segment {
                                Capsule()
                                    .fill(Color.green)
                                    .frame(height: 4)
                                   .matchedGeometryEffect(id: "Tab", in: name)
                                ///@Namespace in SwiftUI is used in combination with the matchedGeometryEffect modifier to create smooth animations between views that are logically connected, even if they’re not in the same place in the view hierarchy.
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SegmentedView()
}
