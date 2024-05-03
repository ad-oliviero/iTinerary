import SwiftUI

struct PersonalPreferencesView: View {
    @State private var selectedIndices: [Int?] = Array(repeating: nil, count: 8)

    let choices: [[String]] = [["Adventure", "Relax"], ["Public transport", "Private transport"], ["Cultural trip", "Entertainment"], ["Local cuisine", "International cuisine"], ["City exploration", "Nature immersion"], ["Wheelchair", "No Wheelchair"], ["No vegan", "Vegan"], ["Gluten Free", "With Gluten"]]
    
    var allChoicesMade: Bool {
        !selectedIndices.contains(nil)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Pick one per category")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    

                ForEach(choices.indices, id: \.self) { index in
                    HStack {
                        Button(action: {
                            toggleSelection(for: index, optionIndex: 0)
                        }) {
                            Text(choices[index][0])
                                .foregroundColor(selectedIndices[index] == 0 ? .white : .blue)
                                .padding()
                                .background(selectedIndices[index] == 0 ? Color.blue : Color.blue.opacity(0.2))
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Text("or")

                        Button(action: {
                            toggleSelection(for: index, optionIndex: 1)
                        }) {
                            Text(choices[index][1])
                                .foregroundColor(selectedIndices[index] == 1 ? .white : .blue)
                                .padding()
                                .background(selectedIndices[index] == 1 ? Color.blue : Color.blue.opacity(0.2))
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Personal Preferences")
            .navigationBarItems(
                trailing: Group {
                    if allChoicesMade {
                        NavigationLink(destination: MainPageView()) {
                            HStack {
                                Text("Next")
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15))
                                    .font(.title)
                            }
                        }
                    } else {
                        
                        HStack {
                            Text("Next").foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 15))
                                .font(.title).foregroundColor(.gray)
                        }
                    }
                }
            )
        }
    }
    
    func toggleSelection(for index: Int, optionIndex: Int) {
        if selectedIndices[index] == optionIndex {
            selectedIndices[index] = nil
        } else {
            selectedIndices[index] = optionIndex
        }
    }
}

#Preview {
    PersonalPreferencesView()
}

