//
//  List of Exam URLs.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/28.
//

import SwiftUI
import SwiftData

@Model
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
    
    @Query private var Exams: [Exam_Data]
    @Environment(\.modelContext) var Context
    
    var body: some View {
        List{
            ForEach(Exams){ exam in
                HStack{
                    VStack{
                        Text(exam.Exam_Name)
                            .font(.headline)
                        Text(exam.URL)
                            .font(.subheadline)
                            .padding(.leading, 10)
                    }
                    NavigationLink {
                        About_Exam_Page(Exam: exam)
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(Color.blue)
                    }
                }
                .swipeActions{
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        Context.delete(exam)
                    }
                }
            }
        }
        .navigationTitle("Online Exam Data List")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    Add_New_Exam_Data_Page()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct Add_New_Exam_Data_Page: View {
    
    @Environment(\.modelContext) var Context
    @Environment(\.dismiss) var Dismiss
    @State var ExamName: String = ""
    @State var ExamURL: String = ""
    
    var body: some View {
        VStack{
            TextField("Exam Name", text: $ExamName)
                .frame(height: 55)
                .background(Color.black.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            TextField("Exam URL", text: $ExamURL)
                .frame(height: 55)
                .background(Color.black.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.none)
                .keyboardType(.URL)
                .padding()
            Button(action: {SaveExamData(); Dismiss()}, label: {
                Text("Save")
                    .frame(width: 200, height: 55)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            })
        }
        .navigationTitle("Add New URL")
        .padding()
    }
    func SaveExamData(){
        let NewExamData = Exam_Data(id: UUID().uuidString, Exam_Name: ExamName, URL: ExamURL)
        Context.insert(NewExamData)
    }
}

struct About_Exam_Page: View {
    
    let Exam: Exam_Data
    @Environment(\.modelContext) var Context
    
    var body: some View {
        VStack{
            HStack{
                Text("URL for the exam:")
                Text(Exam.URL)
            }
            .padding()
            Link(destination: URL(string: Exam.URL)!, label: {
                Text("Open URL")
                    .frame(width: 200, height: 55)
                    .background(Color.black.opacity(0.05))
                    .foregroundStyle(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            })
            
            Button(action: {DeleteExamData(Exam)}, label: {
                Text("Delete URL")
                    .frame(width: 200, height: 55)
                    .background(Color.black.opacity(0.05))
                    .foregroundStyle(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            })
        }
        .navigationTitle(Exam.Exam_Name)
        .padding()
    }
    func DeleteExamData(_ item: Exam_Data){
        Context.delete(Exam)
    }
}

#Preview {
    NavigationView{
        List_of_Exam_URLs()
    }
}
