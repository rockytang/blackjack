class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    # recalculate
      # if > 21
        #bust
      #else if == 21
        #stand, not win because dealer can also get 21 for a draw.

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  stand: (playerScore) ->
    # flip hidden card
    console.log('Dealer: ' + @minScore())
    console.log('Player Score: ' + playerScore)

    if !@.at(0).get('revealed')
      @.at(0).flip()
    # recalculate dealer score
    @scores()
    if @minScore() > 21
      console.log 'dealer busts'
      return false

    if @minScore() >= 17 and @minScore() < playerScore
      console.log 'player wins'
      return false

    if @minScore() >= 17 and @minScore() > playerScore
      console.log 'dealer wins'
      return true



    @hit()
    @stand(playerScore)


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    if @minScore() + 10 * @hasAce() == 21
      console.log 'blackjack'
      return [@minScore() + 10 * @hasAce()]

    if @minScore() > 21
      return [@minScore() + " busted!"]


    [@minScore(), @minScore() + 10 * @hasAce()]


