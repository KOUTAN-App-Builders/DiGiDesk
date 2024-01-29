//
//  Book Shelf Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/18.
//

import SwiftUI
import SwiftData
import UIKit
import PDFKit
import Combine

struct Book_Shelf_Page: View {
    
    @Query private var Books: [Book_Data_Model]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                ForEach(Books){ book in
                    NavigationLink {
                        About_Book_Page(Book: book)
                    } label: {
                        VStack(alignment: .leading, spacing: 8){
                            Image(uiImage: book.Book_Image!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                            Text(book.Book_Name)
                                .font(.headline)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .padding()
        }
    }
}

struct About_Book_Page: View {
    
    let Book: Book_Data_Model
    @Environment(\.modelContext) var Context
    
    var body: some View {
        ScrollView{
            Text(Book.Book_Name)
                .font(.headline)
            NavigationLink {
                PDFViewer(Book: Book)
            } label: {
                Text("Open Book PDF File")
                    .frame(width: 200, height: 55)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .padding()
            }
            Button(action: {DeleteBook(Book)}, label: {
                Text("Delete")
                    .frame(width: 200, height: 55)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .padding()
            })
        }
    }
    func DeleteBook(_ item: Book_Data_Model){
        Context.delete(Book)
    }
}

struct PDFViewWrapper: UIViewRepresentable{
    let pdfURL: URL
    
    func makeUIView(context: Context) -> PDFView {
        let PDFView = PDFView()
        PDFView.document = PDFDocument(url: pdfURL)
        return PDFView
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
    }
}

struct PDFViewer: View {
    
    let Book : Book_Data_Model
    
    var body: some View {
        VStack{
            if let pdfDocument = Book.Book_PDF_File{
                PDFViewWrapper(pdfURL: Book.Book_Data_File_URL!)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                HStack{
                    
                }
            }else{
                Text("Loading PDF...")
            }
        }
    }
}

#Preview {
    Book_Shelf_Page()
}
