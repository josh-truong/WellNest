//
//  ReminderCard.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import SwiftUI

struct ReminderCard: View {
    let request: UNNotificationRequest
    @State private var time: String = ""
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))

            VStack {
                Text("Notification set for \(time)")
                    .font(.system(size: 13))
                HStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                    VStack(alignment: .leading) {
                        Text(request.content.title)
                            .font(.system(size: 13))
                        Text(request.content.body)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                    }
                }
            }
        }
        .onAppear {
            let dateComponents = (request.trigger as! UNCalendarNotificationTrigger).dateComponents

            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"

            if let date = Calendar.current.date(from: dateComponents) {
                time = formatter.string(from: date)
            }
        }
    }
}
