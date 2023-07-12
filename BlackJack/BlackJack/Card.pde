/**
 * An object of type Card represents a playing card from a
 * standard Poker deck.  The card has a suit, which
 * can be spades, hearts, diamonds, or clubs.  A spade, heart,
 * diamond, or club has one of the 13 values: ace, 2, 3, 4, 5, 6, 7,
 * 8, 9, 10, jack, queen, or king.  Note that "ace" is considered to be
 * the smallest value.
 */
class Card { // Individual cards
  PImage cardImage;

  // Codes for the 4 suits, plus Joker.
  final static int SPADES = 0, HEARTS = 1, DIAMONDS = 2, CLUBS = 3;

  // Codes for the non-numeric cards.
  // Cards 2 through 10 have their
  // numerical values for their codes.
  final static int ACE = 1, JACK = 11, QUEEN = 12, KING = 13;

  /**
   * This card's suit, one of the constants SPADES, HEARTS, DIAMONDS,
   * or CLUBS.  The suit cannot be changed after the card is
   * constructed.
   */
  public final int suit;

  /**
   * The card's value.  For a normal cards, this is one of the values
   * 1 through 13, with 1 representing ACE. The value cannot be changed after the card
   * is constructed.
   */
  public final int value;

  /**
   * Creates a card with a specified suit and value.
   * Note: a suit and value have to be specified when creating a card,
   * there is no constructor  Card().
   * @param theValue the value of the new card with a value in the range 1 through 13,
   * with 1 representing an Ace.
   * You can use the constants Card.ACE, Card.JACK, Card.QUEEN, and Card.KING.
   * @param theSuit the suit of the new card.  This must be one of the values
   * Card.SPADES, Card.HEARTS, Card.DIAMONDS, or Card.CLUBS.
   * @throws IllegalArgumentException if the parameter values are not in the
   * permissible ranges
   */
  Card (int theValue, int theSuit) {
    if (theSuit != SPADES && theSuit != HEARTS && theSuit != DIAMONDS && theSuit != CLUBS) {
      throw new IllegalArgumentException ("Illegal playing card suit"); // Checks whether the suit is valid (has to be from 1-4).
    }
    if (theValue < 1 || theValue > 13) {
      throw new IllegalArgumentException ("Illegal playing card value"); // Checks whether the number is valid (has to be from 1-13).
    }
    // If the card is valid, set the cards suit and value.
    value = theValue;
    suit = theSuit;
    // Give the image to the card.
    String filename = "images/" + suit + "-" + value + ".jpg";
    cardImage = loadImage (filename); //Loads the image.
  }


  /**
   * Returns the suit of this card.
   * @returns the suit, which is one of the constants Card.SPADES,
   * Card.HEARTS, Card.DIAMONDS, Card.CLUBS.
   */
  public int getSuit() {
    return suit; // Returns suit of card.
  }


  /**
   * Returns the value of this card.
   * @return the value, which is one the numbers 1 through 13.
   */
  public int getValue() {
    return value; // Returns value of card.
  }


  /**
   * Returns a String representation of the card's suit.
   * @return one of the strings "Spades", "Hearts", "Diamonds", or "Clubs".
   */
  public String getSuitAsString() {
    // Returns the respective suit as its name.
    if (suit == 0) {
      return "Spades";
    } else if (suit == 1) {
      return "Hearts";
    } else if (suit == 2) {
      return "Diamonds";
    } else
      return "Clubs";
  }


  /**
   * Returns a String representation of the card's value.
   * @return for a regular card, one of the strings "Ace", "2",
   * "3", ..., "10", "Jack", "Queen", or "King".
   */
  public String getValueAsString() {
    // Returns the value of the card as a string.
    switch (value) {
    case 1:
      return "Ace";

    case 2:
      return "2";

    case 3:
      return "3";

    case 4:
      return "4";

    case 5:
      return "5";

    case 6:
      return "6";

    case 7:
      return "7";

    case 8:
      return "8";

    case 9:
      return "9";

    case 10:
      return "10";

    case 11:
      return "Jack";

    case 12:
      return "Queen";

    case 13:
      return "King";

    default: // If the card isn't valid, say so.
      return "Invalid playing card value";
    }
  }


  /**
   * Returns a string representation of this card, including both
   * its suit and its value.  Sample return values
   * are: "Queen of Hearts", "10 of Diamonds", "Ace of Spades".
   */
  public String toString() {
    return getValueAsString() + " of " + getSuitAsString(); // Returns the value and suit as a strinb.
  }


  /**
   * Gets the image assigned to the card.
   */
  public PImage getImage() {
    return this.cardImage; //Gets the image and returns it.
  }


  /**
   * Sets the image to be used for the Card.
   */
  public void setImage (PImage cImage) {
    this.cardImage = cImage; //Sets the image.
  }

  /**
   * Draws the card to the screen at the position (xArg, yArg).
   */
  public void drawCard (int xArg, int yArg) {
    image (cardImage, xArg, yArg); //Draws the card.
  }
} // end class Card
