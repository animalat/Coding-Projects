// Represents a Deck of cards.
// Initially contains 52 unshuffled playing cards.
class Deck { // Many cards in a deck

  public ArrayList<Card> cards; //stores the cards in the deck.

  public Card cardBack; // Has the image for the back of a card.

  //Purpose: creates instance of deck (constructor)
  //Parameters:none
  //Returns:none
  Deck() {
    initializeDeck();
  }

  //Purpose:prepares a deck by creating a new deck with 52 unshuffled playing cards()
  //Parameters:none
  //Returns:none
  public void initializeDeck() {
    cards = new ArrayList<Card>();
    PImage img; //For the card picture.
    String filename; // For the image name.

    // Puts all 52 cards in the deck (13 cards times 4 suits)
    for (int suit = 0; suit < 4; suit++) {
      for (int value = 1; value < 14; value++) {
        Card playingCard = new Card (value, suit);
        cards.add (playingCard);
      }
    }

    // Load the back of the card.
    // Use the image "card-back.jpg"
    cardBack = new Card (1, 0); // The card back doesn't have a value or suit, just assign anything.
    filename = "images/card-back.jpg";
    img = loadImage (filename); //Loads the image.
    cardBack.setImage (img); //Sets the image for the card.
  }

  //Purpose: Gives a card where the card's image is the back on all cards.
  //Parameters:none
  //Returns: A card with it's image set to the back of a card.
  public Card getCardBack() {
    return cardBack; // Return the card's back image.
  }

  //Purpose:to shuffle deck
  //Parameters:none
  //Returns:none
  public void shuffle() {

    ArrayList<Card> shuffledDeck = new ArrayList<Card>();
    int index;

    // Randomly shuffle the deck.
    for (int deckSize = cards.size(); deckSize >= 1; deckSize--) {
      index = (int) (Math.random() * deckSize);
      shuffledDeck.add (cards.remove (index));
    }

    cards = shuffledDeck;
  }

  //Purpose:to reset and shuffle deck by overwriting previous deck with new shuffled deck.
  //Parameters:none
  //Returns:none
  public void resetAndShuffleDeck() {
    initializeDeck();
    shuffle();
  }

  //Purpose:to determine the number of cards left in the deck
  //Parameters:none
  //Returns:the number of cards remaining (int)
  public int cardsLeft() {
    return cards.size();
  }

  //Purpose:to deal the next card in the deck
  //Parameters:none
  //Returns:the next card in the deck
  public Card dealCard() {
    if (cardsLeft() == 0) { //if no cards are left throw exception
      println("No cards left in the desk.");
    }
    return cards.remove (0);
  }
} // Deck class
