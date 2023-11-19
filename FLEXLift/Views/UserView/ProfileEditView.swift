//
//  ProfileEditView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import SwiftUI

struct ProfileEditView: View {
    @State var firstName: String = ""
    @State var gender: String = ""
    @State var birthday: String = ""
    @State var weight: String = ""
    @State var height: String = ""
    
    @EnvironmentObject var user: User
    @State private var isLinkActive = false

    
    var body: some View {
        VStack(spacing:30) {
            Text("FLEX Lift")
                .font(.largeTitle)
                .padding(.all)
            Spacer()
            HStack(){
                TextField("Name", text: $firstName)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 300.0, height: 50.0)
                }
                .padding(.horizontal)
                .frame(width: 320, height: 50.0)
            }
            HStack(){
                TextField("Gender", text: $gender)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 300.0, height: 50.0)
                }
                .padding(.horizontal)
                .frame(width: 320, height: 50.0)
            }
            HStack(){
                TextField("Birthday: MM/dd/yyyy", text: $birthday)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 300.0, height: 50.0)
                }
                .padding(.horizontal)
                .frame(width: 320, height: 50.0)
            }
            HStack(){
                TextField("Weight", text: $weight)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 300.0, height: 50.0)
                }
                .padding(.horizontal)
                .frame(width: 320, height: 50.0)
            }
            HStack(){
                TextField("Height", text: $height)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 300.0, height: 50.0)
                }
                .padding(.horizontal)
                .frame(width: 320, height: 50.0)
            }
            NavigationLink(destination: UserMainView()) {
                        Text("Save")
                            .padding(.horizontal, 30.0)
                            .padding(.vertical, 15.0)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color("AccentColor")))
                            .frame(width: 150.0, height: 50)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        user.age = calculateAge(fromBirthdate: birthday) ?? 0
                        user.name = firstName
                        user.gender = gender
                        if let heightValue = Int(height) {
                            // Successfully converted String to Int
                            user.height = heightValue
                            print("The integer value is \(user.height)")
                        } else {
                            // The conversion failed because the string did not contain a valid integer
                            print("'\(height)' is not a valid integer")
                        }
                        if let weightValue = Int(weight) {
                            // Successfully converted String to Int
                            user.weight = weightValue
                            print("The integer value is \(user.height)")
                        } else {
                            // The conversion failed because the string did not contain a valid integer
                            print("'\(height)' is not a valid integer")
                        }
                        user.profileSetup = true
                        isLinkActive = true
                    })
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

func calculateAge(fromBirthdate birthdateString: String) -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    if let birthDate = dateFormatter.date(from: birthdateString) {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        return ageComponents.year
    } else {
        // birthdateString was not in the correct format
        return 0
    }
}


#Preview {
    ProfileEditView()
        .environmentObject(User())
        .environmentObject(BluetoothManager())
}
