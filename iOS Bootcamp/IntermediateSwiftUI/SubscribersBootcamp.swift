//
//  SubscribersBootcamp.swift
//  iOS Bootcamp
//
//  Created by Macuser on 02/11/2023.
//

import SwiftUI
import Combine

class SubscribersViewModel: ObservableObject {
    @Published var count: Int = 30
    private var cancellables = Set<AnyCancellable>()
    var timer: AnyCancellable?
    
    @Published var text: String = ""
    @Published var textIsValid: Bool = false
    @Published var enableButton: Bool = false
    
    init(){
        startTimer()
        textSubscriber()
        buttonSubscriber()
    }
    
    func startTimer(){
        /*
         timer = Timer.publish(every: 1.0, on: .main, in: .common)
             .autoconnect()
             .sink { [weak self] _ in
                 guard let self = self else {return}
                 self.count += 1
                 if self.count >= 10 {
                     self.timer?.cancel()
                 }
             }
         */
        
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.count -= 1
                if self.count == 0 {
                    self.cancellables.forEach({ $0.cancel() })
                    self.text = ""
                    self.textIsValid = false
                }
            }
            .store(in: &cancellables)
    }
    
    func textSubscriber(){
        $text
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            // strong self
            /*
             .map { (text) -> Bool in
                 text.count >= 3
             }
             .assign(to: \.textIsValid, on: self)
             */
            // weak self
            .sink(receiveValue: { [weak self] value in
                self?.textIsValid = value.count >= 3
            })
            .store(in: &cancellables)
    }
    
    func buttonSubscriber(){
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                self.enableButton = isValid && count >= 3
            }
            .store(in: &cancellables)
    }
}

struct SubscribersBootcamp: View {
    
    @StateObject var vm = SubscribersViewModel()
    
    var body: some View {
        VStack(spacing: 12){
            Text(String(format: "%02d", vm.count))
            HStack{
                TextField("Type here...", text: $vm.text)
                Image(systemName: vm.textIsValid ? "checkmark" : "xmark")
                    .foregroundColor(vm.textIsValid ? .blue : .gray)
            }
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
                    .opacity(vm.enableButton ? 1.0 : 0.5)
            }
            .disabled(!vm.enableButton)
        }
        .padding()
    }
}

struct SubscribersBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscribersBootcamp()
    }
}

