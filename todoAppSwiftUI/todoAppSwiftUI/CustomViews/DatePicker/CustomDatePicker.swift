import SwiftUI

struct CustomDatePicker: View {
    @Binding var selection: Date
    let label: String
    
    var body: some View {
        DatePicker(
            label,
            selection: $selection,
            displayedComponents: [.date]
        )
        .environment(\.locale, Locale.current)
        .environment(\.timeZone, TimeZone.current)
        .datePickerStyle(.compact)
    }
}
