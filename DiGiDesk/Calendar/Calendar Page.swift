//
//  Calendar Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/12.
//

import SwiftUI
import SwiftData

struct Calendar_Page: View {
    
    @Query private var taskData: [Task_Data]
    @Query private var StudyRings: [Study_Rings_Data]
    @State private var viewModel = Calendar_Task_ViewModel()
    @State private var isBottomSheetPresented: Bool = false
    
    var body: some View {
            VStack{
                Calendar_View(interval: DateInterval(start: .distantPast, end: .distantFuture)){ dateComponents in
                    guard let date = dateComponents.date else { return }
                    viewModel.searchDate = date
                    isBottomSheetPresented = true
                }
            }
        .navigationTitle("Calendar Page")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    Create_Calendar_Task_View()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isBottomSheetPresented, content: {
            Daily_Task_Sheet_View(searchDate: viewModel.searchDate)
                .presentationDetents([.medium, .large])
        })
    }
}

struct Calendar_View: UIViewRepresentable{
    
    let interval: DateInterval
    let didSelectDate: (_ dateComponents: DateComponents) -> Void
    init(interval: DateInterval, didSelectDate: @escaping(_ dateComponents: DateComponents)-> Void){
        self.interval = interval
        self.didSelectDate = didSelectDate
    }
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        
        view.calendar = Calendar(identifier: .gregorian)
        view.selectionBehavior = selection
        view.availableDateRange = interval
        return view
    }
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(didSelectDate: didSelectDate)
    }
    
    final class Coordinator: NSObject, UICalendarSelectionSingleDateDelegate{
        
        let didSelectDate: (_ dateComponents: DateComponents) -> Void
        init(didSelectDate: @escaping(_ dateComponents: DateComponents)-> Void){
            self.didSelectDate = didSelectDate
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateComponents else { return }
            didSelectDate(dateComponents)
        }
    }
    
}

#Preview {
    NavigationView{
        Calendar_Page()
    }
}
