// Name: nakshayan
// Date Started: March 22, 2023
// Description: Lets the user search for a password in a known passwords list (find top 1000000 passwords list on Wikipedia),
// and displays if that passwords was found in the top passwords, and what place it was found in (what its position, 1 indexed, was in the original document).

import java.util.Map; // Imports hashmaps.

void setup()
{
  // Loads the whole file of passwords into an array.
  String[] passwords = loadStrings("text_to_search.txt");

  // Hashmap that stores the original order of the array (1 indexed, so "123456", the most used password, gets a value of 1).
  HashMap<String, Integer> orderOfPasswords = new HashMap<String, Integer>(passwords.length);

  for (int i = 0; i < passwords.length; i++) { // Goes through every element of the passwords array and assigns it a number in the hashmap corresponding to its order.
    orderOfPasswords.put(passwords[i], i+1); // Assigns the order of each password in the hashmap e.g. "123456" is the 1st most used password.
  }

  passwords = sort(passwords); // Sorts the list of passwords alphabetically.

  // Prints all of the passwords to the console.
  for (int i = 0; i < passwords.length; i++) {
    println(passwords[i]);
  }
  println(); // Prints a new line character for formatting.
  println("There are " + passwords.length + " passwords in the file."); // Prints how many passwords there are.


  String userInputtedPassword; // Stores the password that the user types in (and wants to search for).
  int passwordPosition; // Stores the position of the password that the user asks to search for (in the new, sorted array).

  while (true) { // Loops until the user types "exit!" (continuously searches for passwords the user types in).
    userInputtedPassword = getString("What password would you like to search for? Type \"exit!\" to stop."); // Gets the password the user wants to search for.
    if ((userInputtedPassword.toLowerCase()).equals("exit!")) { // If the user inputs "exit!", stop asking for new passwords to search for (stop the while loop).
      break;
    }
    passwordPosition = binSearch(passwords, userInputtedPassword); // Searches for the inputted password using the binary search method.
    if (passwordPosition == -1) { // If binSearch returns -1, it means that the password (that the user inputted) wasn't in the array.
      println("This password does not exist in this file."); // Tell the user that the password wasn't in the array.
    } else {
      // If binSearch returns any value except -1, it means the password (that the user inputted) was found in the array of passwords.
      //Tell the user that the password they inputted was found in the array,
      // and tell them how common it was (so tells them the position that the password was originally, 1-indexed, before the array was sorted).
      // Uses the hashmap from earlier to tell this position to the user.
      println("This password was found and is the " + orderOfPasswords.get(passwords[passwordPosition]) + " most used password.");
    }
  }
}

// Description: Does a binary search on an array of strings to find a specific element.
// Parameters:
// list[] - a sorted array of strings (that you're trying to find the element in).
// item - a string that you're trying to search for (looking for position of item in list[]).
// Preconditions: Inserted array into list[] must already be sorted.
// Returns: The position of the string you're looking for in the array. Returns a -1 value if the string is not found.
public static int binSearch (String list[], String item)
{
  int bottom = 0; // lower bound index of subarray
  int top = list.length - 1; // upper bound index of subarray
  int middle; // middle index of subarray
  boolean found = false; // to stop if item found
  int location = -1; // index of item in array, returns -1 if not found
  while (bottom <= top && !found) // Loops (keeps searching) until
  {
    middle = (bottom + top) / 2;
    if (list [middle].equals(item)) // successfully found the element.
    {
      found = true; // Found the element (so stop looping).
      location = middle; // Set the location of the found element to the place where the element was found (in the middle).
    } else if (item.compareTo(list[middle]) > 0) // not in left half
    {
      bottom = middle + 1; // Cuts off the left half.
    } else // item cannot be in right half
    {
      top = middle - 1; // Cuts off the right half.
    }
  }
  return location; // Returns the final location of the element we're looking for (-1 if not found).
}
