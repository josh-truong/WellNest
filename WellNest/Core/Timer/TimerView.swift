//
//  Timer.swift
//  WellNest
//
//  Created by Joshua Truong on 11/29/23.
//
import SwiftUI
import CircularProgress

struct TimerView: View {
    @State var count = 0
    let total = 10
    var progress: CGFloat {
        return CGFloat(count)/CGFloat(total)
    }
    
    @State private var time: (hr: Int, min: Int, sec: Int) = (0,0,0)
    @State private var editMode: Bool = true
    
    var body: some View {
        VStack {
            CircularProgressView(count: count, total: total, progress: progress, lineWidth: 15, showText: false)
                .overlay {
                    VStack {
                        Text("Total time: __h __ m __ s")
                        Spacer()
                        if (editMode) {
                            TimePickerView(hour: $time.hr, minute: $time.min, second: $time.sec)
                        }
                        else {
                            Text(String(format: "%02d %02d %02d", time.hr, time.min, time.sec))
                                .font(.system(size: 40))
                        }
                        
                        Spacer()
                        HStack {
                            Image(systemName: "bell.fill")
                            Text("12-hr format")
                        }
                    }
                    .padding(70)
                }
                .padding(20)
            HStack {
            }
            .padding(50)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
