//
//  QuotesWidget.swift
//  QuotesWidget
//
//  Created by Ainur on 10.05.2025.
//

import WidgetKit
import SwiftUI
import Foundation
// MARK: - Timeline Entry

struct QuotesEntry: TimelineEntry {
    let date: Date
    let quote: DailyRectangle
}

// MARK: - Timeline Provider

struct QuotesProvider: TimelineProvider {
    func placeholder(in context: Context) -> QuotesEntry {
        QuotesEntry(date: Date(), quote: quotes[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (QuotesEntry) -> Void) {
        let entry = QuotesEntry(date: Date(), quote: quotes.randomElement()!)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuotesEntry>) -> Void) {
        let entry = QuotesEntry(date: Date(), quote: quotes.randomElement()!)
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 6, to: Date())! // обновляется каждые 6 часов
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

// MARK: - Виджетный UI

struct QuotesWidgetEntryView: View {
    var entry: QuotesProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("“\(entry.quote.text)”")
                .font(.headline)
                .minimumScaleFactor(0.7)
            Text("— \(entry.quote.authorText)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color("WidgetBackground"))
    }
}

// MARK: - Widget Definition

@main
struct QuotesWidget: Widget {
    let kind: String = "QuoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuotesProvider()) { entry in
            QuotesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Цитата дня")
        .description("Получай вдохновение каждый день.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

