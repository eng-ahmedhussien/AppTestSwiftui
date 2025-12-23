//
//  AttachmentUploadView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//


import SwiftUI
import UniformTypeIdentifiers

struct AttachmentUploadView: View {
    @State private var importing = false
    @State private var attachments: [AttachmentItem] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var mediaIds: [String] {
        attachments.compactMap { $0.mediaId }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Upload Button
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
                    Text("Attachments (\(mediaIds.count) uploaded)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(attachments.indices, id: \.self) { index in
                        AttachmentRow(
                            attachment: attachments[index],
                            onRemove: {
                                removeAttachment(at: index)
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
        .alert("Upload Status", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
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
                
                defer {
                    // Stop accessing when done
                    file.stopAccessingSecurityScopedResource()
                }
                
                // Read file data
                do {
                    let fileData = try Data(contentsOf: file)
                    let fileSize = formatFileSize(bytes: fileData.count)
                    let fileType = getFileType(from: file)
                    
                    // Create attachment item
                    let attachment = AttachmentItem(
                        url: file,
                        name: file.lastPathComponent,
                        type: fileType,
                        fileSize: fileSize,
                        isUploading: true
                    )
                    
                    // Add to list
                    attachments.append(attachment)
                    let index = attachments.count - 1
                    
                    print("Added: \(file.lastPathComponent)")
                    
                    // Upload file
                   // handleFileUpload(data: fileData, type: fileType, index: index)
                    
                } catch {
                    print("Error reading file: \(error.localizedDescription)")
                }
            }
            
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
//    private func handleFileUpload(data: Data, type: AttachmentType, index: Int) {
//        let typeString = type == .pdf ? "pdf" : "img"
//        
//        ApiService.uploadMedia(jsonFile: data, type: typeString, completion: { media, failure, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("Data Error: \(String(describing: error))")
//                    self.alertMessage = "Upload failed: \(error.localizedDescription)"
//                    self.showAlert = true
//                    self.attachments[index].isUploading = false
//                } else if let failure = failure {
//                    print("Upload Failure: \(String(describing: failure))")
//                    self.alertMessage = "Upload failed"
//                    self.showAlert = true
//                    self.attachments[index].isUploading = false
//                } else {
//                    if let media = media, let mediaId = media.id {
//                        self.attachments[index].mediaId = mediaId
//                        self.attachments[index].isUploading = false
//                        print("Media ID: \(mediaId)")
//                        print("All Media IDs: \(self.mediaIds)")
//                        self.alertMessage = "File uploaded successfully"
//                        self.showAlert = true
//                    }
//                }
//            }
//        })
//    }
    
    private func removeAttachment(at index: Int) {
        attachments.remove(at: index)
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
    
    private func formatFileSize(bytes: Int) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(bytes))
    }
}

// MARK: - Attachment Models

struct AttachmentItem: Identifiable {
    let id = UUID()
    let url: URL
    let name: String
    let type: AttachmentType
    let fileSize: String
    var mediaId: String? = nil
    var isUploading: Bool = false
}

enum AttachmentType {
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

struct AttachmentRow: View {
    let attachment: AttachmentItem
    let onRemove: () -> Void
    
    var body: some View {
        HStack {
            // Icon
            Image(systemName: attachment.type.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                // File name
                Text(attachment.name)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .font(.body)
                
                HStack(spacing: 8) {
                    // File size
                    Text(attachment.fileSize)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    // Upload status
                    if attachment.isUploading {
                        ProgressView()
                            .scaleEffect(0.7)
                        Text("Uploading...")
                            .font(.caption)
                            .foregroundColor(.orange)
                    } else if attachment.mediaId != nil {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.caption)
                        Text("Uploaded")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
            }
            
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
    AttachmentUploadView()
}
