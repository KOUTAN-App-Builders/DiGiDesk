//
//  Book Data Manager.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/19.
//

import Foundation
import SwiftUI
import SwiftData


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
