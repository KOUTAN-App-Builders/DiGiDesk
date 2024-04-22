//
//  PDF Display Test Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/04/20.
//

import SwiftUI
import PDFKit

struct PDF_Display_Test_Page: View {
    
    @State private var selectedPDFURL: URL?
    @State private var openFile: Bool = false
    
    var body: some View {
        VStack{
            Button(action: {openFile.toggle()}, label: {
                Text("Select PDF here!")
            })
            /*
            if let url = selectedPDFURL{
                PDFViewer(pdfURL: url)
            }else{
                Text("Select a PDF!")
            }*/
        }
            .fileImporter(isPresented: $openFile, allowedContentTypes: [.pdf]) { result in
                if case .success(let URL) = result {
                    selectedPDFURL = URL
                }
            }
    }
}

#Preview {
    PDF_Display_Test_Page()
}
