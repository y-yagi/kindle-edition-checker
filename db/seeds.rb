if User.exists? && !Book.exists?
  Book.create!(isbn_10: '4800006198', user: User.first)
  sleep 3
  Book.create!(isbn_10: '4800004551', user: User.first)
end
