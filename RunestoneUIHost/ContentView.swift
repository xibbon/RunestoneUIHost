//
//  ContentView.swift
//  RunestoneUIHost
//
//  Created by Miguel de Icaza on 3/28/24.
//

import SwiftUI
import RunestoneUI
import TreeSitterGDScriptRunestone

struct ContentView: View, TextViewUIDelegate {
    @State var text = "#!/bin/bash\necho hello"
    let languageMode = TreeSitterLanguageMode(language: .gdscript)
    @State var location: CGRect = CGRect (x: 190, y: 90, width: 1, height: 1)
    let completions = ["_child", "_children", "_child_count", "_groups", "_index", "_last_exclusive_window"]
    @State var commands = TextViewCommands()
    
    func getDefaultAcceptButton () -> some View {
        Image (systemName: "return")
            .padding(5)
            .background { Color.accentColor }
            .foregroundStyle(.background)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    func item (_ v: String) -> some View {
        HStack (spacing: 0){
            Image (systemName: "function")
                .padding (4)
                .background { Color.cyan.brightness(0.2) }
                .padding ([.trailing], 5)
            Text ("get") + Text (v).foregroundStyle(.secondary)
        }
        .padding (3)
        .padding ([.horizontal], 3)
    }
    var body: some View {
        VStack (alignment: .leading){
            Text ("Runestone text:")
            ZStack (alignment: .topLeading){
                TextViewUI(text: $text, commands: commands, delegate: self)
                    .language(.gdscript)
                    .indentStrategy(.tab(length: 4))
                VStack (alignment: .leading){
                    Grid (alignment: .leading) {
                        ForEach (completions, id: \.self) { v in
                            GridRow {
                                item (v)
                                    .background {
                                        if v == "_child" { Color.blue.opacity(0.3)
                                        }
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 4))

                                if v == "_child" {
                                    getDefaultAcceptButton()
                                } else {
                                    EmptyView()
                                }
                            }

                        }
                    }
                }
                .padding(8) // Add padding inside the capsule
                .fontDesign(.monospaced)
                .font(.footnote)
                .clipShape (RoundedRectangle(cornerRadius: 6, style: .circular))
                .overlay {
                    RoundedRectangle(cornerRadius: 6, style: .circular)
                        .stroke(Color.gray, lineWidth: 1) // Add a border
                        
                        //.shadow(color: Color.gray, radius: 3, x: 3, y: 3)
                }
                .position(x: location.maxX+130, y: location.maxY+110)
            }
//            Divider ()
//            Text ("Contents as a TextEditor are:")
            //TextEditor(text: $text)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
