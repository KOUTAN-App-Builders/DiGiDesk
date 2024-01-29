//
//  List of Exam URLs.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/28.
//

import SwiftUI

class Exam_Data: Identifiable{
    var id: String
    var Exam_Name: String
    var URL: String
    init(id: String, Exam_Name: String, URL: String) {
        self.id = UUID().uuidString
        self.Exam_Name = Exam_Name
        self.URL = URL
    }
}

struct List_of_Exam_URLs: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    List_of_Exam_URLs()
}
