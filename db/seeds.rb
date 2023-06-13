# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
# p "start seeding...."
# 10.times do |i|
#   # Create a new user
#   user = User.create!(
#     email: "user#{i}@example.com",
#     password: "password",
#     name: "User #{i}",
#     height: 170 + i,
#     dietary_requirements: ["Vegetarian"],
#     surname: "Surname#{i}",
#     date_of_birth: "1990-01-01",
#     gender: "Male"
#   )

#   # Create a new weekly plan for the user
#   weekly_plan = WeeklyPlan.create!(
#     fitness_goal: "Weight Loss",
#     current_weight: 85 + i,
#     user_id: user.id,
#     weight_goal: 75 + i
#   )

#   # Iterate over 7 days to create day plans
#   (1..7).each do |day_number|
#     day_plan = DayPlan.create!(
#       day_number: day_number,
#       weekly_plan_id: weekly_plan.id
#     )

#     # Create a diet plan for each day
#     DietPlan.create!(
#       day_plan_id: day_plan.id,
#       day_plan_content: "breakfast: Oatmeal with fruits, lunch: Grilled chicken salad, snack: Almonds and a banana, dinner: Quinoa and grilled vegetables"
#     )

#     # Create an exercise plan for each day
#     ExercisePlan.create!(
#       day_plan_id: day_plan.id,
#       day_plan_content: "exercise_1: Treadmill - 30 minutes, exercise_2: Squats - 3 sets of 10, exercise_3: Bench Press - 3 sets of 10, exercise_4: Lunges - 3 sets of 10, exercise_5: Plank - 3 sets of 1 minute"
#     )
#   end
# end

Exercise.destroy_all

exercise_types = ["cardio", "strength"]
muscles = [
  "chest",
  "lats",
  "lower_back",
  "biceps",
  "triceps",
  "traps",
  "quadriceps",
  "abdominals",
  "hamstrings",
  "calves"
]
difficulties = ["beginner", "intermediate", "expert"]

exercise_api_client = ExercisesApiClient.new

exercise_types.each do |type|
  muscles.each do |muscle|
    difficulties.each do |difficulty|
      sleep(0.5)
      result = JSON.parse(exercise_api_client.fetch_exercises(type, muscle, difficulty, 10))
      result.each do |exercise|
        Exercise.create!(
          name: exercise["name"],
          exercise_type: type,
          muscle: muscle,
          difficulty: difficulty,
          instructions: exercise["instructions"]
        )
      end
    end
# p "start seeding...."
# 10.times do |i|
  # Create a new user
  # user = User.create!(
  #   email: "user#{i}@example.com",
  #   password: "password",
  #   name: "User #{i}",
  #   height: 170 + i,
  #   dietary_requirements: ["Vegetarian"],
  #   surname: "Surname#{i}",
  #   date_of_birth: "1990-01-01",
  #   gender: "Male"
  # )

  # Create a new weekly plan for the user
#   weekly_plan = WeeklyPlan.create!(
#     fitness_goal: "Weight Loss",
#     current_weight: 85 + i,
    # user_id: user.id,
#     profile: Profile.last,
#     weight_goal: 75 + i
#   )

  # Iterate over 7 days to create day plans
#   (1..7).each do |day_number|
#     day_plan = DayPlan.create!(
#       day_number: day_number,
#       weekly_plan_id: weekly_plan.id
#     )

    # Create a diet plan for each day
#     DietPlan.create!(
#       day_plan_id: day_plan.id,
#       day_plan_content: "breakfast: Oatmeal with fruits, lunch: Grilled chicken salad, snack: Almonds and a banana, dinner: Quinoa and grilled vegetables"
#     )

    # Create an exercise plan for each day
#     ExercisePlan.create!(
#       day_plan_id: day_plan.id,
#       day_plan_content: "exercise_1: Treadmill - 30 minutes, exercise_2: Squats - 3 sets of 10, exercise_3: Bench Press - 3 sets of 10, exercise_4: Lunges - 3 sets of 10, exercise_5: Plank - 3 sets of 1 minute"
#     )
#   end
# end

Video.destroy_all

Video.create(
  title: "Video 1",
  url: "https://www.youtube.com/embed/VI3muCQbMyo"
)

Video.create(
  title: "Video 2",
  url: "https://www.youtube.com/embed/S12mLBAECV0"
)
Video.create(
  title: "Video 3",
  url: "https://www.youtube.com/embed/eNEgR1fyros"
)

Video.create(
  title: "Video 4",
  url: "https://www.youtube.com/embed/PZvwzobkCUM"
)

p "seeding done!"
