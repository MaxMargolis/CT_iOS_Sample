//
//  EventCreator.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 5/27/25.
//

import SwiftUI
import CleverTapSDK

struct EventCreator: View {
    @State private var eventName = ""
    @State private var eventPropertyKeys = [""]
    @State private var eventPropertyValues = [""]
    var body: some View {
        VStack(spacing: 10) {
            Button {
                sendEventButtonPressed()
            } label: {
                Text("Send Event")
            }
            .padding(50)

            HStack {
                Spacer()
                Text("Event").padding(10)
                TextField("Event Name", text: $eventName)
            }
          
            ForEach(eventPropertyKeys.indices, id: \.self) { index in
              HStack{
                  Spacer()
                  Text("Property \(index + 1)").padding(10)
                  TextField("Key", text: $eventPropertyKeys[index]).padding(10)
                  TextField("Value", text: $eventPropertyValues[index]).padding(10)
                  Spacer()
              }
            }
            Button {
              eventPropertyKeys.append("")
              eventPropertyValues.append("")
              print("Current Keys: \(eventPropertyKeys)")
              print("Current Values: \(eventPropertyValues)")
            } label: {
              Image(systemName: "plus.circle")
                  .foregroundColor(Color.black)
            }
            .padding(20)
            Spacer()
        }
    }
    
    private func sendEventButtonPressed() {
        
//        var dob = DateComponents()
//        dob.day = 1
//        dob.month = 4
//        dob.year = 1976
//        let d = Calendar.current.date(from: dob)
//        
//        let userProperties = ["Gender": "F",
//                              "DOB": d!,
//                              "Customer Type": "Grand",
//                              "Favorite Color": "Chartreuse"] as [String : Any]
//        
//        CleverTap.sharedInstance()?.profilePush(userProperties)
        
//        let fooEventProperties = ["Product Type": "Bar X",
//                                  "Price": 19.99,
//                                  "Category": "Bar and Grill"] as [String : Any]
//        
//        CleverTap.sharedInstance()?.recordEvent("Foo", withProps: fooEventProperties)
        
        if !eventName.isEmpty && eventPropertyKeys.count == eventPropertyValues.count {
            CleverTap.sharedInstance()?.recordEvent(eventName, withProps: Dictionary(keys: eventPropertyKeys, values: eventPropertyValues))
        }
    }
}

extension Dictionary {
    public init(keys: [Key], values: [Value]) {
        precondition(keys.count == values.count)

        self.init()

        for (index, key) in keys.enumerated() {
            self[key] = values[index]
        }
    }
}

#Preview {
    EventCreator()
}
