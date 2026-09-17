defmodule EnhancedChatbot do
  @help_message "I can respond to greetings, tell jokes, show the time, and answer basic questions. Try asking me 'what is your name' or 'tell me a joke'!"

  # Define patterns and responses. 
  # For dynamic responses like time, we map to an atom (:time) and handle it in the logic.
  @patterns_responses [
    {~r/\b(hi|hello|hey)\b/i, ["Hello!", "Hi there!", "Hey! How can I help you?"]},
    {~r/\bhow are you\b/i, ["I'm doing well, thanks!", "I'm just a program, but I'm functioning perfectly!"]},
    {~r/\bwhat is your name\b/i, ["I'm SimpleBot, a rule-based chatbot.", "You can call me SimpleBot!"]},
    {~r/\btime\b/i, :time},
    {~r/\bweather\b/i, ["I can't check the weather yet, that would require an API integration."]},
    {~r/\bjoke\b/i, [
      "Why don't scientists trust atoms? Because they make up everything!",
      "What do you call a fake noodle? An impasta!",
      "Why did the scarecrow win an award? Because he was outstanding in his field!"
    ]},
    {~r/\bthank you\b/i, ["You're welcome!", "Happy to help!", "No problem!"]},
    {~r/\bbye\b/i, ["Goodbye!", "See you later!", "Take care!"]}
  ]

  def start do
    IO.puts(String.duplicate("=", 50))
    IO.puts("Enhanced Rule-Based Chatbot")
    IO.puts("Type 'bye' to exit the conversation")
    IO.puts("Type 'help' for assistance")
    IO.puts(String.duplicate("=", 50))

    # Initialize context map to store conversation state
    initial_state = %{
      user_name: nil,
      last_topic: nil,
      questions_asked: 0
    }
    
    loop(initial_state)
  end

  # Main chatbot loop accepting the current state
  defp loop(state) do
    user_input = IO.gets("\nYou: ") |> String.trim() |> String.downcase()
    
    # Update questions_asked in a new state variable
    state = %{state | questions_asked: state.questions_asked + 1}

    # Evaluate the input conditions
    cond do
      user_input == "bye" ->
        if state.user_name do
          IO.puts("\nChatbot: Goodbye, #{state.user_name}! Have a great day!")
        else
          IO.puts("\nChatbot: Goodbye! Have a great day!")
        end

      user_input == "help" ->
        IO.puts("\nChatbot: #{@help_message}")
        loop(state)

      # Check for name introduction using Regex
      name_match = Regex.run(~r/my name is (\w+)/, user_input) ->
        [_, name] = name_match
        capitalized_name = String.capitalize(name)
        IO.puts("\nChatbot: Nice to meet you, #{capitalized_name}! How can I help you today?")
        
        # Recurse with the user_name populated
        loop(%{state | user_name: capitalized_name})

      true ->
        # Try to match patterns and get the response/new state
        {response, new_state} = process_patterns(user_input, state)
        IO.puts("\nChatbot: #{response}")
        loop(new_state)
    end
  end

  defp process_patterns(input, state) do
    # Find the first regex pattern that matches the input
    match = Enum.find(@patterns_responses, fn {regex, _responses} ->
      Regex.match?(regex, input)
    end)

    case match do
      # Handle dynamic time generation
      {regex, :time} ->
        # Fetches UTC time, drops the milliseconds, converts to string
        current_time = Time.utc_now() |> Time.truncate(:second) |> Time.to_string()
        {"The current time is #{current_time}", %{state | last_topic: regex}}

      # Handle randomized list of responses
      {regex, responses} ->
        {Enum.random(responses), %{state | last_topic: regex}}

      # Default fallback
      nil ->
        {"I'm not sure I understand. Type 'help' for assistance.", state}
    end
  end
end

EnhancedChatbot.start()
