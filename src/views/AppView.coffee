class window.AppView extends Backbone.View
  template: _.template '
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    # for later, when hit stand button, then set hide attr on hit button
    'click .stand-button': -> @model.get('dealerHand').stand(@model.get('playerHand').scores()[0])

  initialize: ->
    @render()
    @model.get('dealerHand').on 'playerWins', @playerWins, this

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

