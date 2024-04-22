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

struct Book_Shelf_Page: View {
    
    @Query private var Books: [Book_Data_Model]
    @State var isListViewSelected: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView{
            HStack{
                Button(action: {isListViewSelected = false}, label: {
                    if isListViewSelected == false{
                        Image(systemName: "rectangle.grid.1x2.fill")
                    }else{
                        Image(systemName: "rectangle.grid.1x2")
                    }
                })
                Button(action: {isListViewSelected = true}, label: {
                    if isListViewSelected == false{
                        Image(systemName: "list.bullet.rectangle")
                    }else{
                        Image(systemName: "list.bullet.rectangle.fill")
                    }
                })
            }
            .padding(.leading)
            VStack(alignment: .leading, spacing: 20){
                if isListViewSelected == false{
                    ForEach(Books){ book in
                        NavigationLink {
                            About_Book_Page(Book: book)
                        } label: {
                            VStack(alignment: .leading, spacing: 8){
                                Image(uiImage: UIImage(data: book.Book_Image!)!)
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
                    /*
                    NavigationLink {
                        PDF_Display_Test_Page()
                    } label: {
                        Text("Test Page")
                    }*/
                }else{
                    ForEach(Books){ book in
                        NavigationLink {
                            About_Book_Page(Book: book)
                        } label: {
                            HStack{
                                Image(uiImage: UIImage(data: book.Book_Image!)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 90, height: 120)
                                Text(book.Book_Name)
                                    .bold()
                                    .padding(.leading)
                            }
                            .padding()
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Book Shelf")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        Add_New_Book_Page()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $searchText)
        }
    }
}

struct About_Book_Page: View {
    
    let Book: Book_Data_Model
    @Environment(\.modelContext) var Context
    
    var body: some View {
        ScrollView{
            if let uiImage = UIImage(data: Book.Book_Image!){
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .shadow(radius: 10)
            }
            if let pdfData = Book.Book_PDF_Document_Data{
                NavigationLink {
                    PDFViewer(pdfData: pdfData)
                } label: {
                    Text("Open Book PDF File")
                        .frame(width: 200, height: 55)
                        .background(Color.black.opacity(0.05))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .padding()
                }
            }else{
                NavigationLink {
                    VStack{
                        Text("PDF File wasn't found!")
                            .font(.title)
                            .foregroundStyle(Color.red)
                        Text("Please delete this book data set and create a new one.")
                            .font(.headline)
                    }
                } label: {
                    Text("Open Book PDF File")
                        .frame(width: 200, height: 55)
                        .background(Color.black.opacity(0.05))
                        .foregroundStyle(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }

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
        .navigationTitle(Book.Book_Name)
    }
    func DeleteBook(_ item: Book_Data_Model){
        Context.delete(Book)
    }
}

struct PDFViewWrapper: UIViewRepresentable{
    let pdfData: Data
    
    func makeUIView(context: Context) -> PDFView {
        let PDFView = PDFView()
        PDFView.autoScales = true
        PDFView.document = PDFDocument(data: pdfData)
        return PDFView
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(data: pdfData)
    }
}

struct PDFViewer: View {
    
    let pdfData: Data
    
    var body: some View {
        PDFViewWrapper(pdfData: pdfData)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NavigationView{
        Book_Shelf_Page()
    }
}
