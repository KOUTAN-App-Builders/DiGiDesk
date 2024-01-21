//
//  Add New Book Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/19.
//

import SwiftUI
import SwiftData

struct Add_New_Book_Page: View {
    
    @Environment(\.modelContext) var Context
    @Environment(\.dismiss) var Dismiss
    @StateObject private var ViewModel = ImagePDFViewModel()
    @State private var ShowAlert: Bool = false
    
    @State var Book_Name: String = ""
    
    var body: some View {
        VStack{
            TextField("Book Name", text: $Book_Name)
                .frame(width: 200, height: 55)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .padding()
                Button(action: {ViewModel.chooseImage()}, label: {
                    Text("Add Image")
                })
            Button(action: {ViewModel.choosePDF()}, label: {
                Text("Add PDF File")
            })
            if let selectedImage = ViewModel.selectedImage{
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
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                })
            }
        }
        .padding()
        .navigationTitle("Add New Book")
        .sheet(isPresented: $ViewModel.isImagePickerPresented, content: {
            ImagePicker(image: $ViewModel.selectedImage)
        })
        .sheet(isPresented: $ViewModel.isDocumentPickerPresented, content: {
            DocumentPicker(documentURL: $ViewModel.selectedPDFURL)
        })
        .alert(isPresented: $ShowAlert) {
            Alert(title: Text("Missing Image"), message: Text("Please choose an image before saving."), dismissButton: .default(Text("OK")))
        }
    }
    func AddBook(){
        let New_Book = Book_Data_Model(id: UUID().uuidString, Book_Name: Book_Name, Book_Image: ViewModel.selectedImage!, Book_Data_File_URL: ViewModel.selectedPDFURL)
        Context.insert(New_Book)
    }
}

#Preview {
    NavigationView{
        Add_New_Book_Page()
    }
}
