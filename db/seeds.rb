# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

10.times do |i|
  # Create a new user
  user = User.create!(
    email: "user#{i}@example.com",
    password: "password",
    name: "User #{i}",
    height: 170 + i,
    dietary_requirements: ["Vegetarian"],
    surname: "Surname#{i}",
    date_of_birth: "1990-01-01",
    gender: "Male"
  )

  # Create a new weekly plan for the user
  weekly_plan = WeeklyPlan.create!(
    fitness_goal: "Weight Loss",
    current_weight: 85 + i,
    user: user,
    weight_goal: 75 + i
  )

  # Iterate over 7 days to create day plans
  (1..7).each do |day_number|
    day_plan = DayPlan.create!(
      day_number: day_number,
      weekly_plan: weekly_plan
    )

    # Create a diet plan for each day
    DietPlan.create!(
      day_plan: day_plan,
      day_plan_content:
        {
          breakfast: "Oatmeal with fruits",
          lunch: "Grilled chicken salad",
          snack: "Almonds and a banana",
          dinner: "Quinoa and grilled vegetables"
        }.to_json
    )

    # Create an exercise plan for each day
    ExercisePlan.create!(
      day_plan: day_plan,
      day_plan_content:
        {
          exercise_1: "Treadmill - 30 minutes",
          exercise_2: "Squats - 3 sets of 10",
          exercise_3: "Bench Press - 3 sets of 10",
          exercise_4: "Lunges - 3 sets of 10",
          exercise_5: "Plank - 3 sets of 1 minute"
        }.to_json
    )
  end
end
