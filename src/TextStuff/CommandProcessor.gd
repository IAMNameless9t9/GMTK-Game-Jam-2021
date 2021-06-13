extends Node

func process_command(input: String):
	var words = input.to_lower().split(" ", false, 0)
	
	if words.size() == 0:
		return "Error: no words were parsed."
	
	var first_word = words[0]
	var second_word = ""
	
	if words.size() > 1:
		return confused()
	
	match first_word:
		"go":
			return go()
		"help":
			return help()
		"here": 
			return here()
		"come": 
			return here()
		"away": 
			return go()
		"sit": 
			return stop()
		"stop": 
			return stop()
		"jump": 
			return jump()
		"fetch": 
			return fetch()
		"grab": 
			return grab()
		"drop": 
			return drop()
		"bark":
			return bark()
		_:
			return default()


func go() -> String:
	return "The dog seems to be further away."

func help() -> String:
	return "Try 'Come' or 'Fetch'?"

func here() -> String:
	return "The dog seems to come closer."

func stop () -> String:
	return "The dog has stopped."

func jump () -> String:
	return "The dog has jumped."

func fetch () -> String:
	return "The dog is moving towards %s." % "something"

func grab() -> String:
	return "The dog has %s in its mouth." % "something"

func drop() -> String:
	return "The dog dropped it."

func bark() -> String:
	return "Good job, you have forced a dog to bark."

func default() -> String:
	return "The dog looks confused."

func confused() -> String:
	return "The dog looks confused."
