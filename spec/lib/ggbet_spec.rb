require_relative '../../lib/ggbet'

class Cache
  def write(key, value)
  end
end

describe GGBet do

  let(:ggbet) { GGBet.new(Cache.new) }

  before { ggbet.stub(:logger) { stub.as_null_object } }

  specify :toggle_logo do
    expect { ggbet.toggle_logo("1") }.not_to raise_error
    expect { ggbet.toggle_logo("2") }.to raise_error(ArgumentError)
  end

  specify :toggle_widget do
    expect { ggbet.toggle_widget("1") }.not_to raise_error
    expect { ggbet.toggle_widget("2") }.to raise_error(ArgumentError)
  end

end