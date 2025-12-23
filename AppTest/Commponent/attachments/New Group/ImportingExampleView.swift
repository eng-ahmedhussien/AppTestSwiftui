//
//  ImportingExampleView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//
import SwiftUI
import UniformTypeIdentifiers


struct AttachmentUploadView1: View {
    @State private var importing = false
    @State private var attachments: [AttachmentItem1] = []
    
    var body: some View {
        VStack(spacing: 16) {
             
            Button(action: {
                importing = true
            }) {
                HStack {
                    Image(systemName: "paperclip")
                    Text("Add Attachment")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .fileImporter(
                isPresented: $importing,
                allowedContentTypes: [.image, .pdf],
                allowsMultipleSelection: true
            ) { result in
                handleFileSelection(result)
            }
            
                // Attachments List
            if !attachments.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Attachments")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(attachments) { attachment in
                        AttachmentRow1(
                            attachment: attachment,
                            onRemove: {
                                removeAttachment(attachment)
                            }
                        )
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
        }
        .padding()
    }
    
    private func handleFileSelection(_ result: Result<[URL], Error>) {
        switch result {
            case .success(let files):
                for file in files {
                        // Start accessing security-scoped resource
                    guard file.startAccessingSecurityScopedResource() else {
                        print("Failed to access: \(file)")
                        continue
                    }
                    
                        // Create attachment item
                    let attachment = AttachmentItem1(
                        url: file,
                        name: file.lastPathComponent,
                        type: getFileType(from: file)
                    )
                    attachments.append(attachment)
                    
                        // Stop accessing (you should keep this until you're done with the file)
                    file.stopAccessingSecurityScopedResource()
                    
                    print("Added: \(file.absoluteString)")
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
        }
    }
    
    private func removeAttachment(_ attachment: AttachmentItem1) {
        attachments.removeAll { $0.id == attachment.id }
    }
    
    private func getFileType(from url: URL) -> AttachmentType {
        let ext = url.pathExtension.lowercased()
        switch ext {
            case "jpg", "jpeg", "png", "heic", "gif":
                return .image
            case "pdf":
                return .pdf
            default:
                return .other
        }
    }
}

    // MARK: - Attachment Models

struct AttachmentItem1: Identifiable {
    let id = UUID()
    let url: URL
    let name: String
    let type: AttachmentType
}

enum AttachmentType1 {
    case image
    case pdf
    case other
    
    var icon: String {
        switch self {
            case .image:
                return "photo"
            case .pdf:
                return "doc.fill"
            case .other:
                return "doc"
        }
    }
}

    // MARK: - Attachment Row

struct AttachmentRow1: View {
    let attachment: AttachmentItem1
    let onRemove: () -> Void
    
    var body: some View {
        HStack {
                // Icon
            Image(systemName: attachment.type.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
                // File name
            Text(attachment.name)
                .lineLimit(1)
                .truncationMode(.middle)
            
            Spacer()
            
                // Remove button
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

    // MARK: - Preview

#Preview {
    AttachmentUploadView1()
}

//#Preview {
//    VStack{
//        ImportingExampleView()
//    }
//}
