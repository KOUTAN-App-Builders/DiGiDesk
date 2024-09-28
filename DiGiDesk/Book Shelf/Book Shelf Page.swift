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
import Vision

struct Book_Shelf_Page: View {
    
    @Query private var Books: [Book_Data_Model]
    @State var isListViewSelected: Bool = false
    @State private var searchText: String = ""
    let columns = [
        GridItem(.adaptive(minimum: 250))
    ]
    
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
                    LazyVGrid(columns: columns, spacing: 20){
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
    @Binding var searchResults: [String]
    
    func makeUIView(context: Context) -> PDFView {
        let PDFView = PDFView()
        
        PDFView.autoScales = true
        PDFView.document = PDFDocument(data: pdfData)
        PDFView.displayMode = .singlePageContinuous
        PDFView.displaysAsBook = true
        PDFView.displayDirection = .vertical
        
        return PDFView
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(data: pdfData)
        //uiView.highlightedSearchResults(in: uiView)
    }
    /*private func highlightSearchResults(in pdfView: PDFView){
        guard let selections = pdfView.document?.selection(for: searchResults.joined(separator: " "), options: [.caseInsensitive]) else { return }
        pdfView.highlightedSelections = [selections]
    }*/
}

struct PDFViewer: View {
    
    let pdfData: Data
    @State private var searchText: String = ""
    @State private var searchResults: [String] = []
    @State private var isSearchBarVisible: Bool = false
    //@ObservedObject var textExtractor = PDFTextExtractor()
    
    var body: some View {
        PDFViewWrapper(pdfData: pdfData, searchResults: $searchResults)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    if isSearchBarVisible{
                        HStack{
                            TextField("Search", text: $searchText)
                                /*.onSubmit {
                                    searchPDF()
                                }*/
                                .textFieldStyle(.roundedBorder)
                                .transition(.blurReplace())
                                .padding()
                            Button(action: {
                                withAnimation{
                                    isSearchBarVisible = false
                                }
                            }, label: {
                                Text("Cancel")
                            })
                        }
                    }else{
                        Button(action: {
                            withAnimation{
                                isSearchBarVisible.toggle()
                            }
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                    }
                }
            }
            /*.onAppear{
                textExtractor.extractText(from: PDFDocument(data: pdfData)!)
            }*/
    }
    /*private func searchPDF(){
        searchResults = textExtractor.extractedText.filter{
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }*/
}

/*
class PDFTextExtractor: ObservableObject{
    @Published var extractedText: [String] = []
    
    func extractText(from document: PDFDocument){
        extractedText.removeAll()
        let request = VNRecognizeTextRequest{ [weak self] (request, error) in
            guard let  observations = request.results as? [VNRecognizedTextObservation], error == nil else{ return }
            let pageText = observations.compactMap{ $0.topCandidates(1).first?.string }.joined(separator: "\n")
            DispatchQueue.main.async {
                self?.extractedText.append(pageText)
            }
        }
        request.recognitionLevel = .accurate
        
        for pageIndex in 0..<document.pageCount{
            if let page = document.page(at: pageIndex){
                guard let pageImage = page.thumbnail(of: page.bounds(for: .mediaBox).size, for: .mediaBox).cgImage else { continue }
                let handler = VNImageRequestHandler(cgImage: pageImage, options: [:])
                try? handler.perform([request])
            }
        }
    }
}

extension PDFPage{
    func selections(for searchText: String) -> [PDFSelection]? {
        let selection = self.selection(for: searchText)
        return selection.map{ [$0] }
    }
}
*/

#Preview {
    NavigationView{
        Book_Shelf_Page()
    }
}
