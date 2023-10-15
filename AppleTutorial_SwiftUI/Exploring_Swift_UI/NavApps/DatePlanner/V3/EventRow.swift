/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct EventRow: View {
    let event: Event
    
    var body: some View {
        HStack {
            Image(systemName: event.symbol)
                .sfSymbolStyling()
                .foregroundStyle(event.color)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(event.title)
                    .fontWeight(.bold)

                Text(event.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            if event.isComplete {
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundStyle(.secondary)
            }
            
        }
        .badge(event.remainingTaskCount)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: Event.example)
    }
}
