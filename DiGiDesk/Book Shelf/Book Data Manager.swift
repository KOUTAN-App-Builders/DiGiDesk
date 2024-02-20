//
//  Book Data Manager.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/19.
//

import Foundation
import SwiftUI
import SwiftData
import UIKit
import PDFKit


@Model
class Book_Data_Model: Identifiable{
    var id: String
    var Book_Name: String
    var Book_Image: Data?
    var Book_Data_File_URL: URL?
    
    init(id: String, Book_Name: String, Book_Image: Data?, Book_Data_File_URL: URL?) {
        self.id = UUID().uuidString
        self.Book_Name = Book_Name
        self.Book_Image = Book_Image
        self.Book_Data_File_URL = Book_Data_File_URL
    }
    
}

class ImagePDFViewModel: ObservableObject{
    @Published var selectedImage: UIImage?
    @Published var selectedPDFURL: URL?
    @Published var Book_PDF_File: PDFDocument?
    
    @Published var isImagePickerPresented = false
    @Published var isDocumentPickerPresented = false
    
    func chooseImage(){
        isImagePickerPresented.toggle()
    }
    func choosePDF(){
        isDocumentPickerPresented.toggle()
    }
    func loadPDFDocument(pdfURL: URL){
            guard let document = PDFDocument(url: pdfURL)else{
                return
            }
            Book_PDF_File = document
        }
}

struct DocumentPicker: UIViewControllerRepresentable{
    @Binding var documentURL: URL?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIDocumentPickerDelegate{
        let parent: DocumentPicker
        init(parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let documentURL = urls.first{
                parent.documentURL = documentURL
            }
        }
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.documentURL = nil
        }
    }
    func makeCoordinator() -> Coordinator{
        Coordinator(parent: self)
    }
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController{
        let picker = UIDocumentPickerViewController(documentTypes: [".pdf"], in: .import)
        
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context){
        
    }
}
