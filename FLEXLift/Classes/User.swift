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
    
    func totalExercisesToday() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let today = dateFormatter.string(from: Foundation.Date())
        return workouts.filter { $0.date == today }.flatMap { $0.exercises }.count
    }
    
    func totalWorkoutTimeToday() -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let today = dateFormatter.string(from: Foundation.Date())
        return workouts.filter { $0.date == today }
            .flatMap { $0.exercises }
            .reduce(0) { $0 + $1.duration }
    }
    
    func totalRepsToday() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let today = dateFormatter.string(from: Foundation.Date())
        return workouts.filter { $0.date == today }
            .flatMap { $0.exercises }
            .reduce(0) { $0 + $1.totalReps }
    }
    
    func averageDailyExercises() -> Double {
        let groupedByDate = Dictionary(grouping: workouts, by: { $0.date })
        let totalExercises = groupedByDate.values.reduce(0) { $0 + $1.flatMap { $0.exercises }.count }
        return Double(totalExercises) / Double(groupedByDate.count)
    }
    
    func averageDailyWorkoutTime() -> Double {
        let groupedByDate = Dictionary(grouping: workouts, by: { $0.date })
        let totalWorkoutTime = groupedByDate.values.reduce(0) { $0 + $1.flatMap { $0.exercises }.reduce(0) { $0 + $1.duration } }
        return totalWorkoutTime / Double(groupedByDate.count)
    }
    
    func averageDailyReps() -> Double {
        let groupedByDate = Dictionary(grouping: workouts, by: { $0.date })
        let totalReps = groupedByDate.values.reduce(0) { $0 + $1.flatMap { $0.exercises }.reduce(0) { $0 + $1.totalReps } }
        return Double(totalReps) / Double(groupedByDate.count)
    }
    
    func favoriteExercise() -> String {
        if(workouts.isEmpty){
            return "N/A"
        }
        else{
            let exercisesFlattened = workouts.flatMap { $0.exercises }
            let groupedByType = Dictionary(grouping: exercisesFlattened, by: { $0.exerciseType })
            return groupedByType.max { $0.value.count < $1.value.count }?.key ?? "N/A"
        }
    }
    
    func workoutTimeForPastWeek() -> [String: Double] {
        var dataPoints = [String: Double]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let calendar = Calendar.current
        // Ensure we start from the beginning of the week (Monday)
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else { return dataPoints }
        
        for dayOffset in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else { continue }
            let dateString = dateFormatter.string(from: date)
            
            let totalWorkoutTime = workouts.filter { $0.date == dateString }
                .flatMap { $0.exercises }
                .reduce(0) { $0 + $1.duration }
            dataPoints[dateString] = totalWorkoutTime
        }
        
        return dataPoints
    }
    
    func addWorkoutToContainer(exercise: Exercise){
        if(exercise.exerciseType == "Barbell Lunge"){
            barbellLunge.append(exercise)
        }
        else if(exercise.exerciseType == "Barbell Squat"){
            barbellSquat.append(exercise)
        }
        else if(exercise.exerciseType == "Bench Press"){
            benchPress.append(exercise)
        }
        else if(exercise.exerciseType == "Bicep Curl"){
            bicepCurl.append(exercise)
        }
        else if(exercise.exerciseType == "Deadlift"){
            deadlift.append(exercise)
        }
        else if(exercise.exerciseType == "Shoulder Press"){
            shoulderPress.append(exercise)
        }
        else if(exercise.exerciseType == "Power Clean"){
            powerClean.append(exercise)
        }
        else if(exercise.exerciseType == "Power Snatch"){
            powerSnatch.append(exercise)
        }
        else if(exercise.exerciseType == "Squat Clean"){
            squatClean.append(exercise)
        }
        else if(exercise.exerciseType == "Squat Snatch"){
            squatSnatch.append(exercise)
        }
    }
    
    func returnWorkoutToContainer(currentSelection: String) -> [Exercise] {
        if(currentSelection == "Barbell Lunge"){
            return barbellLunge
        }
        else if(currentSelection == "Barbell Squat"){
            return barbellSquat
        }
        else if(currentSelection == "Bench Press"){
            return benchPress
        }
        else if(currentSelection == "Bicep Curl"){
            return bicepCurl
        }
        else if(currentSelection == "Deadlift"){
            return deadlift
        }
        else if(currentSelection == "Shoulder Press"){
            return shoulderPress
        }
        else if(currentSelection == "Power Clean"){
            return powerClean
        }
        else if(currentSelection == "Power Snatch"){
            return powerSnatch
        }
        else if(currentSelection == "Squat Clean"){
            return squatClean
        }
        else if(currentSelection == "Squat Snatch"){
            return squatSnatch
        }
        else{
            return []
        }
    }
    
    func workoutsOnDate(date: String) -> [Workout]{
        return workouts.filter { $0.date == date }
    }
    
    func getWorkoutDates() -> [String] {
        // Create a set to hold unique dates
        var uniqueDates = Set<String>()

        // Iterate over each workout and add its date to the set
        for workout in workouts {
            uniqueDates.insert(workout.date)
        }

        // Convert the set back to an array and return
        return Array(uniqueDates).sorted()
    }
}

