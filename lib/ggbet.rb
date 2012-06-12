class GGBet

  def initialize(cache)
    @cache = cache
  end

  # Toggle visibility of the GGBet logo
  def toggle_logo(value)
    case value
      when '1'
        @cache.write('ggbet_logo', true)
        Rails.logger.info 'ggbet logo enabled'
      when '0'
        @cache.write('ggbet_logo', nil)
        Rails.logger.info 'ggbet logo disabled'
      else
        raise ArgumentError.new('Invalid value passed to #toggle_logo, only "0" or "1" allowed.')
    end
  end

  # Toggle visibility of the GGBet widget
  def toggle_widget(value)
    case value
      when '1'
        @cache.write('ggbet_widget', true)
        Rails.logger.info 'ggbet widget enabled'
      when '0'
        @cache.write('ggbet_widget', nil)
        Rails.logger.info 'ggbet widget disabled'
      else
        raise ArgumentError.new('Invalid value passed to #toggle_logo, only "0" or "1" allowed.')
    end
  end

  def logo?
    @cache.read('ggbet_logo')
  end

  def widget?
    @cache.read('ggbet_widget')
  end

end
