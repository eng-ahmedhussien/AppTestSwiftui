// Deepest level — knows nothing about VM, just fires closures on the model
struct CartItemRow: View {
    let item: CartItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // top row
            HStack {
                Text(item.name)
                    .font(.headline)
                Spacer()
                Text("$\(item.price * Double(item.quantity), specifier: "%.2f")")
                    .foregroundStyle(.secondary)
            }
            
            // bottom row — all buttons fire closures set in VM
            HStack {
                
                // quantity stepper
                HStack(spacing: 12) {
                    Button {
                        item.onQuantityChange?(max(1, item.quantity - 1))
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    
                    Text("\(item.quantity)")
                        .frame(minWidth: 20)
                    
                    Button {
                        item.onQuantityChange?(item.quantity + 1)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                
                Spacer()
                
                // favorite
                Button {
                    item.onFavorite?()
                } label: {
                    Image(systemName: "heart")
                        .foregroundStyle(.pink)
                }
                
                // remove
                Button {
                    item.onRemove?()
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(.vertical, 4)
    }
}