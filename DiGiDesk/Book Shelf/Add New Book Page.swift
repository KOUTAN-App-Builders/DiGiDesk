//
//  Add New Book Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/19.
//

import SwiftUI
import SwiftData
import PhotosUI

struct Add_New_Book_Page: View {
    
    @Environment(\.modelContext) var Context
    @Environment(\.dismiss) var Dismiss
    @StateObject private var ViewModel = ImagePDFViewModel()
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
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
            Button(action: {ViewModel.choosePDF()}, label: {
                Text("Add PDF File")
            })
            if ViewModel.selectedPDFURL != nil{
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
        .sheet(isPresented: $ViewModel.isDocumentPickerPresented, content: {
            DocumentPicker(documentURL: $ViewModel.selectedPDFURL)
        })
        .alert(isPresented: $ShowAlert) {
            Alert(title: Text("Missing PDF File"), message: Text("Please choose a PDF File before saving."), dismissButton: .default(Text("OK")))
        }
        .task(id: selectedPhoto){
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                selectedPhotoData = data
            }
        }
    }
    func AddBook(){
        let New_Book = Book_Data_Model(id: UUID().uuidString, Book_Name: Book_Name, Book_Image: selectedPhotoData!, Book_Data_File_URL: ViewModel.selectedPDFURL)
        Context.insert(New_Book)
    }
}

#Preview {
    NavigationView{
        Add_New_Book_Page()
    }
}
