// An object of type Hand represents a hand of cards. The
// cards belong to the class Card. A hand is empty when it
// is created, and any number of cards can be added to it.
class Hand {

  ArrayList<Card> hand;   // The cards in the hand.

  //Purpose: constructor - Create a hand that is initially empty.
  //Parameters: none
  //Returns: none
  public Hand() { // Many cards in a hand to be played.
    hand = new ArrayList<Card>();
  }

  //Purpose: To shuffle the cards in the hand.
  //Parameters: none
  //Returns: none
  public void shuffle() {
    ArrayList<Card> shuffledHand = new ArrayList<Card>();
    int index;

    for (int handSize = hand.size(); handSize >= 1; handSize--)
    {
      index = (int) (Math.random() * handSize);
      shuffledHand.add (hand.remove (index));
    }

    hand = shuffledHand;
  }

  //Purpose: Remove all cards from the hand, leaving it empty.
  //Parameters: none
  //Returns: none
  public void clear() {
    hand.clear();
  }

  //Purpose: Add a card to the hand. It is added at the end of the current hand.
  //Parameters: cardArg - The card to add to the hand.
  //Returns: none
  public void addCard (Card cardArg) {
    hand.add (cardArg);
  }

  //Purpose: Remove the card passed in from the hand.
  //Parameters: cardArg - The card to be removed from the hand.
  // If cardArg is null or the card is not in the hand then nothing is done.
  //Returns: none
  public void removeCard (Card cardArg) {
    hand.remove (cardArg);
  }

  //Purpose: Remove the card from the hand at the specified position.
  //Parameters: position - the position of the card that is to be removed,
  // where positions start at zero up to card count -1.
  //Returns: The card that was just removed from the hand.
  public  Card removeCard (int position) {
    if (position < 0 || position >= hand.size()) {
      println ("Position does not exist in hand: " + position);
    }
    return hand.remove (position);
  }

  //Purpose: Returns the number of cards in the hand.
  //Parameters: none
  //Returns: The number of cards in the hand.
  public int getCardCount() {
    return hand.size();
  }

  //Purpose: Gets the card from the hand at the specified position.
  //Note: The card returned is not removed from the hand.
  //Parameters: position - the position of the card to get,
  //where positions start at zero up to card count -1.
  //Returns: The card at that position.
  public Card getCard (int position) {
    if (position < 0 || position >= hand.size()) {
      println ("Position does not exist in hand: " + position);
    }
    return (Card) hand.get (position);
  }

  // Purpose: Sorts the cards in the hand so that cards of the same suit are
  // grouped together, and within a suit the cards are sorted by value.
  // Note that aces are considered to have the lowest value, 1.
  // Parameters: None.
  // Returns: Nothing.
  void sortBySuit() {
    ArrayList<Card> newHand = new ArrayList<Card>();
    while (hand.size() > 0) {
      int pos = 0;  // Position of minimal card.
      Card c = (Card) hand.get (0); // Minumal card.
      for (int i = 1; i < hand.size(); i++) {
        Card c1 = (Card) hand.get (i);
        if (c1.getSuit() < c.getSuit() || (c1.getSuit() == c.getSuit() && c1.getValue() < c.getValue())) {
          pos = i;
          c = c1;
        }
      }
      hand.remove (pos);
      newHand.add (c);
    }
    hand = newHand;
  }

  // Purpose: Sorts the cards in the hand so that cards are sorted into order
  // of increasing value.  Cards with the same value are sorted by suit.
  // Note that aces are considered to have the lowest value, 1.
  // Parameters: None.
  // Returns: Nothing.
  public void sortByValue() {
    ArrayList<Card> newHand = new ArrayList<Card>();
    while (hand.size() > 0) {
      int pos = 0;  // Position of minimal card.
      Card c = (Card) hand.get (0); // Minumal card.
      for (int i = 1; i < hand.size(); i++) {
        Card c1 = (Card) hand.get (i);
        if (c1.getValue() < c.getValue() ||
          (c1.getValue() == c.getValue() && c1.getSuit() < c.getSuit())) {
          pos = i;
          c = c1;
        }
      }
      hand.remove (pos);
      newHand.add (c);
    }
    hand = newHand;
  }

  //Description: Draws the hand at (x,y) that is passed in.
  //Parameters:
  // handXPos: The x position of the hand that will be drawn.
  // handYPos: The y position of the hand that will be drawn.
  //Returns: Nothing
  public void drawHand(int handXPos, int handYPos) {
    for (int counter = 0; counter < hand.size(); counter++) {
      hand.get(counter).drawCard(handXPos+25*counter, handYPos);
    }
  }
}
