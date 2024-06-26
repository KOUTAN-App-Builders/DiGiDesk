//
//  Add New Book Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/19.
//

import SwiftUI
import SwiftData
import PDFKit
import PhotosUI
import UniformTypeIdentifiers

struct Add_New_Book_Page: View {
    
    @Environment(\.modelContext) var Context
    @Environment(\.dismiss) var Dismiss
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    @State private var selectedPDFDocument: PDFDocument?
    @State var fileName: String = ""
    @State var selectedFileURL: URL?
    @State var openFile: Bool = false
    @State var saveFile: Bool = false
    
    @State private var ShowAlert: Bool = false
    
    @State var Book_Name: String = ""
    
    var body: some View {
        VStack{
            TextField("Book Name", text: $Book_Name)
                .frame(height: 55)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .padding()
            PhotosPicker(selection: $selectedPhoto,
                         matching: .images,
                         photoLibrary: .shared()){
                Label("Add Image", systemImage: "photo")
                    .frame(width: 200, height: 55)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            if selectedPhotoData != nil{
                Button(role: .destructive){
                    withAnimation{
                        selectedPhoto = nil
                        selectedPhotoData = nil
                    }
                }label:{
                    Label("Remove Image", systemImage: "xmark")
                        .foregroundStyle(.red)
                }
            }
            Button(action: {openFile.toggle()}, label: {
                Text("Select PDF")
                    .frame(width: 200, height: 55)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            if selectedFileURL != nil, selectedPhotoData != nil{
                Button(action: {AddBook(); Dismiss()}, label: {
                    Text("Add Book")
                        .frame(width: 200, height: 55)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                })
            }else{
                Button(action: {ShowAlert = true}, label: {
                    Text("Add Book")
                        .frame(width: 200, height: 55)
                        .background(Color.gray)
                        .foregroundStyle(Color.white)
                        .cornerRadius(10)
                        .padding()
                })
            }
        }
        .navigationTitle("Add New Book")
        .padding()
        .alert(isPresented: $ShowAlert) {
            Alert(title: Text("Missing PDF File or Image"), message: Text("Please choose a PDF File and an image before saving."), dismissButton: .default(Text("OK")))
        }
        .task(id: selectedPhoto){
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                selectedPhotoData = data
            }
        }
        .fileImporter(isPresented: $openFile, allowedContentTypes: [UTType.pdf]) { result in
            switch result {
            case .success(let url):
                guard url.startAccessingSecurityScopedResource() else{
                    print("startAccessingSecurityScopedResouce Error")
                    return
                }
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: url.path){
                    print("File exists at: \(url.path)")
                }else{
                    print("File doesn't exist at: \(url.path)")
                }
                if let document = PDFDocument(url: url){
                    print("PDF Document Loaded Successfully.")
                    self.selectedFileURL = url
                    self.selectedPDFDocument = document
                }
                url.stopAccessingSecurityScopedResource()
            case .failure(let error):
                print("Error occured while selecting file: \(error.localizedDescription)")
            }
        }
    }
    func AddBook(){
        let New_Book = Book_Data_Model(id: UUID().uuidString, Book_Name: Book_Name, Book_Image: selectedPhotoData, Book_Data_File_URL: selectedFileURL!, pdfDocument: selectedPDFDocument!)
        Context.insert(New_Book)
    }
}


#Preview {
    NavigationView{
        Add_New_Book_Page()
    }
}
