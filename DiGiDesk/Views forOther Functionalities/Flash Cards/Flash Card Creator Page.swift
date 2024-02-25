//
//  Flash Card Creator Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/23.
//

import SwiftUI
import SwiftData

@Model
class Flash_Card_Data: Identifiable{
    var fileName: String
    var id: Int
    var Question: String
    var Answer: String
    var Key_Point: String?
    
    init(raw: [String], fileName: String){
        self.fileName = fileName
        self.id = Int(raw[0])!
        self.Question = raw[1]
        self.Answer = raw[2]
        if raw[3] != ""{
            self.Key_Point = raw[3]
        }
    }
    
}

struct Flash_Card_Home_Page: View {
    
    @Query var Flash_Cards: [Flash_Card_Data]
    
    var body: some View {
        ScrollView{
            ForEach(Flash_Cards){ cardSet in
                VStack{
                    NavigationLink {
                        Flash_Card_Detail_Page(Card: cardSet)
                    } label: {
                        Text(cardSet.fileName)
                            .font(.largeTitle)
                    }
                }
            }
        }
        .navigationTitle("Flash Cards List")
        .toolbar(){
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    Flash_Card_Creator_Page()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct Flash_Card_Detail_Page: View {
    let Card: Flash_Card_Data
    @Query var Flash_Cards: [Flash_Card_Data]
    
    var body: some View {
        ScrollView{
            HStack{
                Text("Word Number")
                Spacer()
                Text("Questions")
                Spacer()
                Text("Answers")
            }
            List(Flash_Cards){ card in
                HStack{
                    Text(card.Question)
                    Spacer()
                    Text(card.Answer)
                }
            }
        }
        .navigationTitle(Card.fileName)
        .toolbar(){
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    Flash_Card_Test_Page()
                } label: {
                    Image(systemName: "pencil.and.list.clipboard")
                }
                
            }
        }
    }
}

struct Flash_Card_Test_Page: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}


struct Flash_Card_Creator_Page: View {
    
    @Query var Flash_Cards: [Flash_Card_Data]
    @State var openFile: Bool = false
    @State var selectedFileURL: URL?
    @State var selectedFileName: String = ""
    @Environment(\.dismiss) var Dismiss
    
    var body: some View {
        VStack{
            Button {
                openFile.toggle()
            } label: {
                Text("Import CSV file")
                    .frame(width: 200, height: 55)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Button(action: {Dismiss()}, label: {
                Text("Save")
                    .frame(width: 200, height: 55)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
        .navigationTitle("Add New Flash Cards")
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.spreadsheet]) { (result) in
            do{
                let fileURL = try result.get()
                print(fileURL)
                self.selectedFileURL = fileURL
                self.selectedFileName = fileURL.lastPathComponent
            }
            catch{
                print("error reading documents")
                print(error.localizedDescription)
            }
        }
    }
    func cleanRows(file: String) -> String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    func loadCSVData() -> [Flash_Card_Data]{
        var csvToSwiftData = [Flash_Card_Data]()
        
        guard let filePath = selectedFileURL else{
            print("Error: file not found")
            return[]
        }
        var data = ""
        do{
            data = try String(contentsOf: filePath)
        }catch{
            print(error)
            return[]
        }
        data = cleanRows(file: data)
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        for row in rows {
            let csvColumns = row.components(separatedBy: ",")
            if csvColumns.count == rows.first?.components(separatedBy: ",").count{
                let linesStruct = Flash_Card_Data.init(raw: csvColumns, fileName: selectedFileName)
                csvToSwiftData.append(linesStruct)
            }
        }
        return csvToSwiftData
    }
}

#Preview {
    NavigationView{
        Flash_Card_Home_Page()
    }
}
