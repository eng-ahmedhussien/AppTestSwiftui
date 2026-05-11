 Text("Buy Now")
            .padding()
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue.gradient)
            }
            .overlay(alignment: .topTrailing) {
                Text("9")
                    .alignmentGuide(.top) { dim in
                        dim.height / 2
                    }
                    .alignmentGuide(.trailing) { dim in
                        dim.width / 2
                    }
            }