//
//  User.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import Foundation

class User: ObservableObject{
    @Published var name: String
    @Published var height: Int
    @Published var weight: Int
    @Published var gender: String
    @Published var age: Int
    @Published var profileSetup: Bool
    @Published var tabView: Bool
    @Published var workouts: [Workout]
    @Published var beginWorkout: Bool
    @Published var duringExercise: Bool
    @Published var endExercise: Bool
    @Published var workoutSummary: Bool
    @Published var isTimerRunning: Bool
    @Published var elapsedTime: Double
    @Published var inWorkout: Bool
    @Published var barbellLunge: [Exercise]
    @Published var barbellSquat: [Exercise]
    @Published var benchPress: [Exercise]
    @Published var bicepCurl: [Exercise]
    @Published var deadlift: [Exercise]
    @Published var shoulderPress: [Exercise]
    @Published var powerClean: [Exercise]
    @Published var powerSnatch: [Exercise]
    @Published var squatClean: [Exercise]
    @Published var squatSnatch: [Exercise]
    private var timer: Timer?
    
    init(){
        name = "Enter name"
        height = 0
        weight = 0
        gender = "Select gender"
        age = 0
        profileSetup = false
        tabView = true
        workouts = [Workout()]
        beginWorkout = true
        duringExercise = false
        endExercise = false
        workoutSummary = false
        isTimerRunning = false
        elapsedTime = 0.0
        inWorkout = false
        barbellLunge = []
        barbellSquat = []
        benchPress = []
        bicepCurl = []
        deadlift = []
        shoulderPress = []
        powerClean = []
        powerSnatch = []
        squatClean = []
        squatSnatch = []
    }
    
    func startTimer() {
            isTimerRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        }
    
    func pauseTimer() {
            isTimerRunning = false
            timer?.invalidate()
            timer = nil
        }

    func resetTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
    }

}
