//
//  About Book Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/19.
//

import SwiftUI
import SwiftData

struct About_Book_Page: View {
    
    @Query private var Books: [Book_Data_Model]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    About_Book_Page()
}
