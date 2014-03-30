# encoding: UTF-8
survey "Kitchen Sink survey", :default_mandatory => false do
  section "Basic questions" do
    # A basic question with checkboxes
    # The "question" and "answer" methods may be abbreviated as "q" and "a".
    # Append a reference identifier (a short string used for dependencies and validations) using the "_" underscore.
    # Question reference identifiers must be unique within a survey.
    # Answer reference identifiers must be unique within a question
    q_2 "Choose the colors you don't like", :pick => :any
    a_1 "red"
    a_2 "blue"
    a_3 "green"
    a_4 "yellow"
    a :omit

    # A dependent question, with conditions and rule to logically join them
    # If the conditions, logically joined into the rule, are met, then the question will be shown.
    q_2a "Please explain why you don't like this color?"
    a_1 "explanation", :text, :help_text => "Please give an explanation for each color you don't like"
    dependency :rule => "A or B or C or D"
    condition_A :q_2, "==", :a_1
    condition_B :q_2, "==", :a_2
    condition_C :q_2, "==", :a_3
    condition_D :q_2, "==", :a_4

    # The count operator checks how many responses exist for the referenced question.
    # It understands conditions of the form: count== count!= count> count< count>= count<=
    q_2b "Please explain why you dislike so many colors?"
    a_1 "explanation", :text
    dependency :rule => "Z"
    condition_Z :q_2, "count>2"
  end
end
