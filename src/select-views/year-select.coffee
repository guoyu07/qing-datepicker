SelectView = require './select-view.coffee'

class YearSelect extends SelectView

  @opts:
    locales: null

  _setOptions: (opts) ->
    super
    $.extend @opts, YearSelect.opts, opts

  _init: ->
    super
    @year = moment().year()
    @currentYear = @year

  _render: ->
    super
    @el.find('.title').text @opts.locales.selectYear
    @el.addClass 'year-select'

  _renderGrid: ->
    @grid.empty()

    start = @year - 4
    end = @year + 4
    for year in [start..end]
      $year = $ '<a>',
        href: 'javascript:;'
        class: 'grid-item link-year'
        'data-year': year
        text: year

      $year.addClass('current') if year == moment().year()
      $year.addClass('selected') if year == @currentYear
      $year.appendTo @grid

    @grid

  _bind: ->
    super

    @el.on 'click', '.link-prev', (e) =>
      @year -= 9
      @_renderGrid()

    @el.on 'click', '.link-next', (e) =>
      @year += 9
      @_renderGrid()

    @el.on 'click', '.link-year', (e) =>
      $link = $ e.currentTarget
      year = $link.data('year')
      @trigger 'select', [year]

  setYear: (year) ->
    @year = year
    @currentYear = year
    @_renderGrid()
    @year

module.exports = YearSelect
