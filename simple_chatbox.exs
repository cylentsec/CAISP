defmodule SimpleChatbot do
  # Module attribute holding our dictionary of responses
  @responses %{
    "hello" => "Hi there! How can I assist you today?",
    "how are you" => "I'm just a program, but I'm functioning as expected!",
    "what is your name" => "I'm SimpleBot, a rule-based chatbot.",
    "what can you do" => "I can answer simple questions based on predefined patterns.",
    "bye" => "Goodbye! Have a great day!"
  }

  def start do
    IO.puts(String.duplicate("=", 50))
    IO.puts("Simple Rule-Based Chatbot")
    IO.puts("Type 'bye' to exit the conversation")
    IO.puts(String.duplicate("=", 50))
    
    # Start the conversation loop
    loop()
  end

  defp loop do
    # Get user input, remove trailing newlines, and convert to lowercase
    user_input = 
      IO.gets("\nYou: ") 
      |> String.trim() 
      |> String.downcase()

    if user_input == "bye" do
      IO.puts("\nChatbot: Goodbye! Have a great day!")
    else
      # Check for a match and print the response, then recurse
      response = find_response(user_input)
      IO.puts("\nChatbot: #{response}")
      loop()
    end
  end

  defp find_response(input) do
    # Search for the first key in @responses that appears in the user input
    match = Enum.find(@responses, fn {pattern, _resp} ->
      String.contains?(input, pattern)
    end)

    case match do
      {_pattern, response} -> response
      nil -> "I'm sorry, I didn't understand that. Can you try asking something else?"
    end
  end
end

# Execute the start function when the script runs
SimpleChatbot.start()
