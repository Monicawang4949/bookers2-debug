5.times do |n|
  user = User.create(
    name: "user#{n+1}",
    email: "test#{n+1}@test.com",
    password: "123456",
  )
  if user.valid?
    puts "User #{n+1} created"
  else
    puts "Error creating user #{n+1}: #{user.errors.full_messages.join(', ')}"
  end
end

User.all.each do |user|
  5.times do |n|
    book = Book.create(
      title: "本#{n+1}",
      body: "サンプル投稿です#{n+1}",
      user_id: user.id,
      created_at: Time.current - rand(10).day
    )
    if book.valid?
      puts "Book for User #{user.id} created"
    else
      puts "Error creating book for User #{user.id}: #{book.errors.full_messages.join(', ')}"
    end
  end
end