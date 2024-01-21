//
//  Book Shelf Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/18.
//

import SwiftUI
import SwiftData
import UIKit

struct Book_Shelf_Page: View {
    
    @Query private var Books: [Book_Data_Model]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                ForEach(Books){ book in
                    BookView(Book: book)
                }
            }
            .padding()
        }
    }
}

struct BookView: View {
    
    let Book: Book_Data_Model
    
    var body: some View {
        NavigationLink {
            About_Book_Page()
        } label: {
            VStack(alignment: .leading, spacing: 8){
                Image(uiImage: Book.Book_Image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Text(Book.Book_Name)
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


#Preview {
    Book_Shelf_Page()
}
