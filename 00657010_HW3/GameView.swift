//
//  GameView.swift
//  00657010_HW3
//
//  Created by Shaun Ku on 2019/11/2.
//  Copyright © 2019 Shaun Ku. All rights reserved.
//

import SwiftUI

struct GameView: View
{
    @Binding var showGamePage:Bool
    @Binding var isProfile:Bool
    @Binding var name:String
    @Binding var birthday: Date
    @Binding var age: Int
    @Binding var isGender:Bool
    @Binding var selectGender:String
    @State private var totalhitTime = 0
    @State private var hitcount = [0,0,0,0,0]
    @State private var showHitAlert = false
    var pick = ["LeBron James", "Emma Watson", "Kevin Hart", "Gordon Ramsay", "Conan O'Brian"]
    var pickName = ["LeBron", "Emma", "Kevin", "Gordon", "Conan"]
    var angry = ["LeBronAngry", "EmmaAngry", "KevinAngry", "GordonAngry", "ConanAngry"]
    //@State private var selectedPic = "LeBron James"
    @State private var selectedIndex = 0
    @State private var scale: CGFloat = 1
    @State private var brightnessAmount: Double = 0
    @State private var selectBlend = BlendMode.screen
    let blendModes: [BlendMode] = [.screen, .colorDodge, .colorBurn]
    var body: some View
    {
        VStack
        {
            
            ProfileDetail(isProfile: self.$isProfile, name: self.$name, birthday: self.$birthday, age: self.$age, isGender: self.$isGender, selectGender: self.$selectGender)
            Text("Instruction: Tap the image to make him/her angry!")
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .font(Font.system(size: 15))
            if hitcount[selectedIndex] < 2
            {
                Text("You've hit \(pickName[selectedIndex]) \(hitcount[selectedIndex]) time!")
                .font((Font.system(size: 26)))
            }
            else
            {
                Text("You've hit \(pickName[selectedIndex]) \(hitcount[selectedIndex]) time!")
                .font((Font.system(size: 26)))
            }
            HStack
            {
                Button(action:
                {
                    self.hitcount[self.selectedIndex] += 1
                    self.totalhitTime += 1
                    if self.totalhitTime % 25 == 0 || self.hitcount[self.selectedIndex] == 50
                    {
                        self.showHitAlert = true
                    }
                })
                {
                    if self.hitcount[self.selectedIndex] >= 50
                    {
                        Image(angry[selectedIndex])
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .brightness(self.brightnessAmount)
                        .frame(width:300, height:200)
                    }
                    else
                    {
                        Image(pickName[selectedIndex])
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .brightness(self.brightnessAmount)
                        .frame(width:300, height:200)
                    }
                }
                .alert(isPresented: $showHitAlert)
                {
                    () -> Alert in
                    if self.hitcount[self.selectedIndex] == 50
                    {
                        return Alert(title: Text("\(pickName[selectedIndex]) is Angry!!"),message: Text("You've hit \(totalhitTime) times in total!"), dismissButton: .default(Text("Keep Going!")))
                    }
                    else
                    {
                      return Alert(title: Text("You've hit \(totalhitTime) times in total!"), dismissButton: .default(Text("Keep Going!")))
                    }
                }
                if self.hitcount[self.selectedIndex] >= 0 && self.hitcount[self.selectedIndex] < 10
                {
                    Image("0")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width:40, height:200)
                    .padding(.leading, 10)
                }
                else if self.hitcount[self.selectedIndex] >= 10 && self.hitcount[self.selectedIndex] < 20
                {
                    Image("1")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width:40, height:200)
                    .padding(.leading, 10)
                }
                else if self.hitcount[self.selectedIndex] >= 20 && self.hitcount[self.selectedIndex] < 30
                {
                    Image("2")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width:40, height:200)
                }
                else if self.hitcount[self.selectedIndex] >= 30 && self.hitcount[self.selectedIndex] < 40
                {
                    Image("3")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width:40, height:200)
                }
                else if self.hitcount[self.selectedIndex] >= 40 && self.hitcount[self.selectedIndex] < 50
                {
                    Image("4")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width:40, height:200)
                }
                else if self.hitcount[self.selectedIndex] >= 50
                {
                    Image("5")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width:40, height:200)
                }
                

            }
            
            VStack
            {
                Text("Select a person you want to hit")
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 10, trailing: 0))
                Picker(selection: $selectedIndex, label: Text("Select a person you want to hit"))
                {
                    /*ForEach(pics, id: \.self)
                    {
                        (pic) in
                        Text(pic)
                    }*/
                    ForEach(0..<pickName.count)
                    {
                        (index) in
                        Text(self.pickName[index])
                    }
                }
                .frame(width: 300, height: 50)
                .clipped()
                .labelsHidden()
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            BrightnessSlider(brightnessAmount: self.$brightnessAmount)
            ZoomSlider(scale: self.$scale)
            
            HStack
            {
                Button(action:
                {
                    self.totalhitTime = 0
                    self.hitcount = [0,0,0,0,0]
                    /*ForEach(0..<hitcount.count)
                    {
                        (index) in
                        self.hitcount[index] = 0
                    }*/
                    self.selectedIndex = 0
                    self.scale = 1
                    self.brightnessAmount = 0
                })
                {
                    HStack
                    {
                        Text("Restart")
                        Image(systemName: "gobackward")
                        .imageScale(.large)
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                        
                }
                Button(action:{self.showGamePage = false})
                {
                    HStack
                    {
                        Text("Exit")
                        Image(systemName: "trash")
                        .imageScale(.large)
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(40)
                        
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider
{
    static var previews: some View
    {
        GameView(showGamePage: .constant(true), isProfile: .constant(true), name: .constant(""), birthday: .constant(Date()), age: .constant(20), isGender: .constant(false), selectGender: .constant(""))
    }
}

struct BrightnessSlider: View
{
    
    @Binding var brightnessAmount: Double
    
    var body: some View
    {
        HStack
        {
            Text("Brightness")
            Slider(value: self.$brightnessAmount, in: 0...1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)){Text("")}
        }
        .frame(width:300)
    }
}

struct ZoomSlider: View
{
    
    @Binding var scale: CGFloat
    
    var body: some View
    {
        HStack
        {
            Text("Zoom")
            Slider(value: self.$scale, in: 0...1)
            Text("\(self.scale, specifier: "%.2f")")
        }
        .frame(width:300)
    }
}

extension BlendMode
{
    var name: String{return "\(self)"}
}

struct ProfileDetail: View
{
    @Binding var isProfile: Bool
    @Binding var name: String
    @Binding var birthday: Date
    @Binding var age: Int
    @Binding var isGender:Bool
    @Binding var selectGender:String
    let dateFormatter: DateFormatter =
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    var body: some View
    {
        HStack
        {
            VStack
            {
                HStack
                {
                    if isProfile
                    {
                        Image("profilepic1")
                        .resizable()
                        .scaledToFill()
                        .frame(width:50, height:50)
                        .clipShape(Circle())
                    }
                    else
                    {
                        Image("profilepic2")
                        .resizable()
                        .scaledToFill()
                        .frame(width:50, height:50)
                        .clipShape(Circle())
                    }
                    Text("\(name), \(age)")
                    .font(Font.custom("Snell Roundhand", size: 25))
                    if isGender
                    {
                        if self.selectGender == "Male"
                        {
                            Image("MaleSymbol")
                            .resizable()
                            .scaledToFill()
                            .frame(width:30, height:30)
                        }
                        else if self.selectGender == "Female"
                        {
                            Image("FemaleSymbol")
                            .resizable()
                            .scaledToFill()
                            .frame(width:30, height:30)
                        }
                        else
                        {
                            Image("QuestionMark")
                            .resizable()
                            .scaledToFill()
                            .frame(width:30, height:30)
                        }
                    }
                }
                Text("\(dateFormatter.string(from: birthday))")
            }
            Spacer()
        }
        .padding()
        
    }
}
