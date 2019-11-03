//
//  IntroView.swift
//  00657010_HW3
//
//  Created by Shaun Ku on 2019/11/2.
//  Copyright © 2019 Shaun Ku. All rights reserved.
//

import SwiftUI

struct IntroView: View
{
    init(){UITableView.appearance().backgroundColor = .clear}
    @State private var isProfile = true
    @State private var name = ""
    @State private var age = 20
    @State private var isGender = false
    @State private var selectGender = "Male"
    let genders = ["Male", "Female", "Others"]
    @State private var birthday = Date()
    @State private var showActionSheet = false
    let dateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    @State private var showGamePage = false
    @State private var showNameAlert = false
    var body: some View
    {
        VStack
        {
            GameNameText()
            if isProfile
            {
                Image("profilepic1")
                .resizable()
                .scaledToFill()
                .frame(width:200, height:150)
                .clipShape(Circle())
            }
            else
            {
                Image("profilepic2")
                .resizable()
                .scaledToFill()
                .frame(width:200, height:150)
                .clipShape(Circle())
                //.hidden()
            }
            
            Toggle("Do you want a profile picture?", isOn: $isProfile)
            .frame(width:300)
            
            TextField("Your Name", text: $name)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            .frame(width:300)
            .multilineTextAlignment(.center)
            
            Stepper(value: $age, in: 1...120)
            {
                if age == 1
                {
                    Text("\(age) year old")
                }
                else
                {
                    Text("\(age) years old")
                }
            }
            .frame(width:200)
            
            Button(action: {self.showActionSheet = true})
            {
                /*let controller = UIAlertController(title: "Proficiency", message: "How well you know the game", preferredStyle: .actionSheet)
                let pros = ["High", "Medium", "Low"]
                for pro in pros
                {
                    let action = UIAlertAction(title: pro, style: .default)
                    {
                        (action) in
                        print(action.title)
                    }
                    controller.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                controller.addAction(cancelAction)
                
                self.present(controller, animated: true, completion: nil)*/
                    Text("Choose your proficiency")
            }
            .actionSheet(isPresented: $showActionSheet)
            {
                ActionSheet(title: Text("Proficiency"), message: Text("How well you know the game"), buttons: [.default(Text("High")), .default(Text("Medium")), .default(Text("Low")), .destructive(Text("Cancel"))])
            }
            
            Form
            {
                Toggle("Do you want to show your gender?", isOn: $isGender)
                if isGender
                {
                    Picker("Gender", selection: $selectGender)
                    {
                        ForEach(genders, id: \.self)
                        {
                            (gender) in
                            Text(gender)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                DatePicker("Your Birthday", selection: $birthday, in:...Date(), displayedComponents: .date)
            }
            .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
            .frame(width:400, height: 300)
            .clipped()
            
            Button(action:
            {
                if self.name == ""
                {
                    self.showNameAlert = true
                }
                else
                {
                    self.showGamePage = true
                }
            })
            {
                HStack
                {
                    Text("START")
                    .fontWeight(.semibold)
                    .font(.title)
                    Image(systemName: "play")
                        .font(.title)
                }
                .padding()
                .foregroundColor(Color.white)
                //.background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom))
                .background(Color.red)
                .cornerRadius(40)
            }
            .alert(isPresented: $showNameAlert)
            {
                () -> Alert in
                return Alert(title: Text("Opps!!!"), message: Text("You haven't enter you name."))
            }
            .sheet(isPresented: self.$showGamePage)
            {
                GameView(showGamePage: self.$showGamePage, isProfile: self.$isProfile, name: self.$name, birthday: self.$birthday, age: self.$age, isGender: self.$isGender, selectGender: self.$selectGender)
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))

        }
    }
}

struct IntroView_Previews: PreviewProvider
{
    static var previews: some View
    {
        IntroView()
    }
}

struct GameNameText: View
{
    var body: some View
    {
        Text("Angry Man💥")
            .font(Font.custom("American Typewritter", size: 30))
            .fontWeight(.bold)
            .foregroundColor(Color.orange)
            .multilineTextAlignment(.center)
            .frame(width:200, height:60)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.purple, lineWidth: 5))
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
