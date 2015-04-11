assert = chai.assert

describe 'game logic', ->
  deck = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()


  it "at start of game, player and dealer have 2 cards each, deck has 48", ->
    assert.strictEqual playerHand.length, 2
    assert.strictEqual dealerHand.length, 2
    assert.strictEqual deck.length, 48

  it "if player > 21, player bust", ->
    # if playerHand.score()[0] > 21
    #   expect()
