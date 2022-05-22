//
//  SosMainViewWidget.swift
//  SosMainViewWidget
//
//  Created by 최윤제 on 2022/05/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SosMainViewWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            Color(.systemPink)
            VStack{
                Text("SOS")
                    .fontWeight(.bold)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 5)
                            .frame(width: 100, height: 100)
                    )
                
            }
        }
    }
}

@main
struct SosMainViewWidget: Widget {
    let kind: String = "SosMainViewWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SosMainViewWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Sos Widget")
        .description("This is Sos Widget")
        .supportedFamilies([.systemSmall])
    }
}

struct SosMainViewWidget_Previews: PreviewProvider {
    static var previews: some View {
        SosMainViewWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
