# encoding: UTF-8
survey "Favorites" do
  section "Foods" do
    # In a quiz, both the questions and the answers need to have reference identifiers
    # Here, the question has reference_identifier: "1", and the answers: "oint", "tweet", and "moo"
    question "What is the best meat?", :pick => :one, :correct => "oink"
    answer "bacon"
    answer "chicken"
    answer "beef"
  end
end
