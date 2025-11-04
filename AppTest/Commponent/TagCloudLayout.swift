//
//  TagCloudLayout.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 28/01/2025.
//
import SwiftUI

struct TagCloudLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        let spacing: CGFloat = 10
        var maxWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(proposal)
            
            if currentX + size.width > (proposal.width ?? .infinity) {
                maxWidth = max(maxWidth, currentX)
                currentX = 0
                currentY += size.height + spacing
            }
            currentX += size.width + spacing
        }

        currentY += subviews.last?.sizeThatFits(proposal).height ?? 0
        maxWidth = max(maxWidth, currentX)
        return CGSize(width: maxWidth, height: currentY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        let spacing: CGFloat = 10

        for subview in subviews {
            let size = subview.sizeThatFits(proposal)
            
            // Wrap to the next row if the current view doesn't fit in the current row
            if currentX + size.width > bounds.width {
                currentX = 0
                currentY += size.height + spacing
            }
            
            // Place the subview at the calculated position
            subview.place(at: CGPoint(x: currentX, y: currentY), proposal: ProposedViewSize(size))
            currentX += size.width + spacing
        }
    }
    


//    // Step 2: Determine the overall size of the layout
//    func sizeThatFits(proposal: ProposedViewSize, subviews: [LayoutSubview], cache: inout Void) -> CGSize {
//     
//    }
}


struct TagCloudView: View {
    let tags = ["SwiftUI", "iOS", "Layout", "Custom", "TagCloud", "Dynamic", "Grid", "Flexible"]

    var body: some View {
        TagCloudLayout {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

#Preview {
    TagCloudView()
}
